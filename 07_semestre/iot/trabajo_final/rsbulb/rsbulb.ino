// WiFi / UDP
#include <ESP8266WiFi.h>
#include <WiFiUdp.h>
#include <ArduinoJson.h>
// IR sensor
#include <IRrecv.h>
// Telegram bot
#include <WiFiClientSecure.h>
#include <UniversalTelegramBot.h>

// environment
#include "secrets.h"

// General
#define DEBUG
#define SERIAL_BAUD 115200

#if defined(DEBUG)
#define DEBUG_PRINT(...) Serial.print(__VA_ARGS__)
#define DEBUG_PRINTF(...) Serial.printf(__VA_ARGS__)
#else
#define DEBUG_PRINT(...) void()
#define DEBUG_PRINTF(...) void()
#endif

#define STATUS_LED_RED 12   // D6
#define STATUS_LED_GREEN 13 // D7
#define STATUS_LED_BLUE 15  // D8
/* Color green */
#define STATUS_MASK_OK 0b00000010
/* Color red */
#define STATUS_MASK_ERROR 0b00000001
/* Color yellow */
#define STATUS_MASK_WARN 0b00000011
/* Color blue */
#define STATUS_MASK_NO_WIFI 0b00000100
/* Color fuchsia */
#define STATUS_MASK_NO_BULB 0b00000101

// WiFi / UDP
#define UDP_LOCAL_PORT 6969
#define UDP_MAX_PACKET_SIZE 384

// Smart bulb
#define SBULB_LISTENING_PORT 38899
#define SBULB_SCAN_ATTEMPS 5
#define SBULB_SCAN_TIMEOUT 1000
#define SBULB_SET_TIMEOUT 500
#define SBULB_SYNC_INTERVAL 10 * 1000
#define LIMIT_BRIGHTNESS(X) ((X) > 100 ? 100 : ((X) < 10 ? 10 : (X)))

// IR sensor
#define IR_SENSOR_PIN 14

#define IR_KEY_CH 0xFF629D
#define IR_KEY_PLAY_PAUSE 0xFFC23D
#define IR_KEY_VOL_UP 0xFFA857
#define IR_KEY_VOL_DOWN 0xFFE01F
#define IR_KEY_EQ 0xFF906F

#define IR_ON_OFF IR_KEY_PLAY_PAUSE
#define IR_BRIGHTNESS_UP IR_KEY_VOL_UP
#define IR_BRIGHTNESS_DOWN IR_KEY_VOL_DOWN
#define IR_BRIGHTNESS_AUTO IR_KEY_CH
#define IR_SEND_UPDATE IR_KEY_EQ

// Light sensor
#define LS_PIN A0
/* Range [0, 1000] */
#define LS_MAX_BRIGHTNESS 800
/* Range [0, 1000] */
#define LS_MIN_BRIGHTNESS 500
/* Range [0, 1000] */
#define LS_DESIRED_BRIGHTNESS 600
#define LS_DIFF_TOLERANCE 50

// Telegram bot
#define TBOT_SCAN_INTERVAL 10 * 1000

// General
int led_state_mask = 0;

// UDP
WiFiUDP udp;

// Smart bulb
const char *bulb_MAC = SBULB_MAC;
const int bulb_port = SBULB_LISTENING_PORT;
IPAddress bulb_ip;
bool bulb_on = false;
int bulb_bri = 50;
bool bulb_bri_auto = false;
bool bulb_response_pending = false;
unsigned long bulb_next_sync = 0;
bool bulb_set_pending = false;
unsigned long bulb_next_set = 0;

// IR sensor
IRrecv irrecv(IR_SENSOR_PIN);
decode_results results;

// Light sensor
/* Range [0, 1023] */
int ls_sensed_brightness = 0;
int ls_desired_brightness = LS_DESIRED_BRIGHTNESS;
bool ls_under_brightness = false;
bool ls_over_brightness = false;
bool ls_notify_under = false;
bool ls_notify_over = false;

// Telegram bot
unsigned long tbot_next_update = 0;
const char *const tbot_chat_ids[] = {
    TBOT_USER_ID_1,
#if defined(TBOT_USER_ID_2)
    TBOT_USER_ID_2,
#endif
#if defined(TBOT_USER_ID_3)
    TBOT_USER_ID_3,
#endif
};
const size_t tbot_chat_ids_length = sizeof(tbot_chat_ids) / sizeof(tbot_chat_ids[0]);
X509List cert(TELEGRAM_CERTIFICATE_ROOT);
WiFiClientSecure client;
UniversalTelegramBot bot(TBOT_TOKEN, client);
IPAddress hola;

void setup()
{
  Serial.begin(SERIAL_BAUD);

  pinMode(STATUS_LED_RED, OUTPUT);
  pinMode(STATUS_LED_GREEN, OUTPUT);
  pinMode(STATUS_LED_BLUE, OUTPUT);

  set_status_led(STATUS_MASK_NO_WIFI);

  DEBUG_PRINT("\n\n\nBooting\n");

  // Setup IR sensor
  irrecv.enableIRIn();

  // Setup WiFi
  WiFi.setSleep(false);
  WiFi.mode(WIFI_STA);
  WiFi.disconnect();
  delay(250);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(1000);
    DEBUG_PRINT(".");
  }
  DEBUG_PRINTF("\nConnected to '%s' with IP %s\n", WIFI_SSID, WiFi.localIP().toString().c_str());

  set_status_led(STATUS_MASK_NO_BULB);

  // Setup smart bulb (retrieve bulb state)
  udp.begin(UDP_LOCAL_PORT); // Need to bind to a port to receive packets

  if (!initialize_bulb_from_scan(bulb_MAC, bulb_ip, bulb_on, bulb_bri))
  {
    DEBUG_PRINT("Failed to initialize bulb\n");
    while (true)
    {
      delay(100);
    }
  }

  // Setup telegram bot
  client.setTrustAnchors(&cert);
  configTime(0, 0, "pool.ntp.org"); // get UTC time via NTP

  set_status_led(STATUS_MASK_OK);
  DEBUG_PRINT("Setup complete\n");
}

void loop()
{
  if (bulb_response_pending)
  {
    int packet_size;
    while ((packet_size = udp.parsePacket()) > 0)
    {
      if (udp.remoteIP() == bulb_ip)
      {
        handle_bulb_response(packet_size);
      }
    }
  }

  bool update_bulb = handle_ir_sensor();

  update_bulb = handle_light_sensor() || update_bulb;

  if (millis() > tbot_next_update)
  {
    update_bulb = handle_telegram_bot() || update_bulb;
    tbot_next_update = millis() + TBOT_SCAN_INTERVAL;
  }

  if (update_bulb || (bulb_set_pending && (millis() > bulb_next_set)))
  {
    udp.beginPacket(bulb_ip, bulb_port);
    udp_write_bulb_set(udp, bulb_on, bulb_bri);
    udp.endPacket();
    udp.flush();
    bulb_response_pending = true;
    bulb_set_pending = true;
    bulb_next_set = millis() + SBULB_SET_TIMEOUT;
    DEBUG_PRINT("Sent bulb update\n");
  }
  else if (millis() > bulb_next_sync)
  {
    udp.beginPacket(bulb_ip, bulb_port);
    udp.write("{\"method\":\"getPilot\"}");
    udp.endPacket();
    udp.flush();
    bulb_response_pending = true;
    bulb_next_sync = millis() + SBULB_SYNC_INTERVAL;
    DEBUG_PRINT("Sent bulb sync request\n");
  }

  delay(10);
}

bool initialize_bulb_from_scan(const char *target_mac, IPAddress &ip, bool &on, int &bri)
{
  JsonDocument doc;
  unsigned long start;
  unsigned long timeout;
  char packet_buff[UDP_MAX_PACKET_SIZE];

  for (int i = 0; i < SBULB_SCAN_ATTEMPS; i++)
  {
    udp.beginPacket("255.255.255.255", bulb_port);
    udp.write("{\"method\":\"getPilot\"}");
    udp.endPacket();

    start = millis();
    timeout = start + (SBULB_SCAN_TIMEOUT)*pow(2, i);
    while (millis() < timeout)
    {
      int packet_size = udp.parsePacket();
      if (packet_size == 0)
      {
        delay(10);
        continue;
      }

      int len = udp.read(packet_buff, UDP_MAX_PACKET_SIZE);
      if (len > 0)
      {
        packet_buff[len] = 0;
      }

      DEBUG_PRINTF("%s:%d send %d bytes: %s\n", udp.remoteIP().toString().c_str(), udp.remotePort(), len, packet_buff);

      DeserializationError error = deserializeJson(doc, packet_buff, UDP_MAX_PACKET_SIZE);
      if (error)
      {
        DEBUG_PRINTF("Failed to parse JSON: %s\n", error.c_str());
        continue;
      }

      const char *method = doc["method"];
      JsonObject result = doc["result"];
      if (method == nullptr || strcmp(method, "getPilot") != 0 || result.isNull())
      {
        DEBUG_PRINT("Invalid initialization packet\n");
        continue;
      }

      const char *result_mac = result["mac"];
      if (method == nullptr || strcmp(result_mac, target_mac) != 0)
      {
        DEBUG_PRINTF("Expected MAC %s, got %s\n", target_mac, result_mac);
        continue;
      }

      ip = udp.remoteIP();

      bool result_state = result["state"];
      int result_dimming = result["dimming"];
      on = result_state;
      bri = result_dimming;
      return true;
    }

    DEBUG_PRINTF("(%d) - Failed to find bulb after %d ms\n", i, millis() - start);
  }

  DEBUG_PRINTF("No bulb found after %d attempts\n", SBULB_SCAN_ATTEMPS);
  return false;
}

bool handle_bulb_response(int psize)
{
  StaticJsonDocument<UDP_MAX_PACKET_SIZE> doc;
  DeserializationError error = deserializeJson(doc, udp);
  if (error)
  {
    DEBUG_PRINTF("Failed to parse JSON: %s\n", error.c_str());
    return false;
  }

  const char *method = doc["method"];
  const JsonObject result = doc["result"];
  if (method == nullptr || result.isNull())
  {
    DEBUG_PRINT("Unexpected bulb packet\n");
    set_status_led(STATUS_MASK_WARN);
    serializeJson(doc, Serial);
    Serial.println();
    return false;
  }

  if (strcmp(method, "setPilot") == 0)
  {
    const bool result_success = result["success"];
    if (result_success)
    {
      DEBUG_PRINT("Received bulb set confirmation\n");
      bulb_set_pending = false;
      bulb_response_pending = false; // set pending of the sync request
      return true;
    }

    DEBUG_PRINT("Bulb set failed\n");
    return false;
  }

  if (strcmp(method, "getPilot") == 0)
  {
    DEBUG_PRINT("Received bulb state\n");
    bool result_state = result["state"];
    int result_dimming = result["dimming"];
    bulb_on = result_state;
    bulb_bri = result_dimming;
    bulb_response_pending = bulb_set_pending;
    return true;
  }

  DEBUG_PRINT("Unhandled bulb packet ->\n");
  serializeJson(doc, Serial);
  Serial.println();
  set_status_led(STATUS_MASK_WARN);
  return false;
}

bool handle_ir_sensor()
{
  if (!irrecv.decode(&results))
  {
    return false;
  }

  bool updated = false;
  int new_bulb_bri = bulb_bri;
  switch (results.value)
  {
  case IR_ON_OFF:
    bulb_on = !bulb_on;
    updated = true;
    break;
  case IR_BRIGHTNESS_UP:
    new_bulb_bri += 10;
    break;
  case IR_BRIGHTNESS_DOWN:
    new_bulb_bri -= 10;
    break;
  case IR_SEND_UPDATE:
    updated = true;
    break;
  case IR_BRIGHTNESS_AUTO:
    bulb_bri_auto = !bulb_bri_auto;
    updated = true;
    break;
  default:
#if defined(DEBUG)
    if (!results.repeat)
    {
      Serial.printf("Unhandled IR value %llx\n", results.value);
    }
#endif
  }

  new_bulb_bri = LIMIT_BRIGHTNESS(new_bulb_bri);
  if (new_bulb_bri != bulb_bri)
  {
    bulb_bri = new_bulb_bri;
    updated = true;
  }

  DEBUG_PRINTF(
      "IR bulb state:\n"
      "  on: %d\n"
      "  bri: %d\n"
      "  auto: %s\n",
      bulb_on,
      bulb_bri,
      bulb_bri_auto ? "true" : "false");

  irrecv.resume(); // only needed when decode its succesfull
  return updated;
}

bool handle_light_sensor()
{
  bool updated = bulb_bri_auto;
  int current_brightness = analogRead(LS_PIN);

  ls_sensed_brightness = map(current_brightness, 0, 1023, 0, 1000);
  ls_under_brightness = ls_sensed_brightness < LS_MIN_BRIGHTNESS;
  ls_over_brightness = ls_sensed_brightness > LS_MAX_BRIGHTNESS;

  if (!updated || !(ls_under_brightness || ls_over_brightness) || (abs(ls_sensed_brightness - ls_desired_brightness) < LS_DIFF_TOLERANCE))
  {
    return false;
  }

  ls_notify_under = ls_under_brightness;
  ls_notify_over = ls_over_brightness;
  int new_brightness = bulb_bri + (ls_under_brightness ? 10 : -10);

  new_brightness = LIMIT_BRIGHTNESS(new_brightness);
  if (new_brightness == bulb_bri)
  {
    return false;
  }

  bulb_bri = new_brightness;
  return true;
}

bool handle_telegram_bot()
{
  bool updated = false;
  int pending_updates = bot.getUpdates(bot.last_message_received + 1);
  if (pending_updates > 0)
  {
    updated = tbot_handle_messages(pending_updates);
  }

  if (ls_notify_over || ls_notify_under)
  {
    char msgbuff[127];
    const int n = snprintf(msgbuff, 128, "Light sensor detected %s brightness", ls_under_brightness ? "low" : "high");
    if (n < 0 || n >= 127)
    {
      DEBUG_PRINTF("Failed to write telegram notification into buffer\n");
      set_status_led(STATUS_MASK_ERROR);
      return false;
    }

    for (size_t i = 0; i < tbot_chat_ids_length; i++)
    {
      bot.sendMessage(tbot_chat_ids[i], msgbuff);
      yield();
    }
    ls_notify_over = false;
    ls_notify_under = false;
  }

  return updated;
}

const char *status_tmpl = ("Current status:\n"
                           "  Bulb: %s\n"
                           "  Brightness: %d\n"
                           "  Auto brightness: %s\n"
                           "  Light sensor: %d\n");

bool tbot_handle_messages(int updates_count)
{
  bool updated = false;
  for (int i = 0; i < updates_count; i++)
  {
    String chat_id = bot.messages[i].chat_id;
    String text;
    for (int j = 0; j < tbot_chat_ids_length; j++)
    {
      if (strcmp(chat_id.c_str(), tbot_chat_ids[j]) == 0)
      {
        text = bot.messages[i].text;
        break;
      }
    }
    if (text.isEmpty())
    {
      DEBUG_PRINTF("Ignoring message from unauthorized chat %s\n", chat_id);
      continue;
    }

    char msgbuff[255];
    if (text == "/start")
    {
      bot.sendMessage(chat_id, "Hello! I'm your smart home assistant. How can I help you?");
    }
    else if (text == "/status")
    {
      const int n = snprintf(msgbuff, 255, status_tmpl, bulb_on ? "on" : "off", bulb_bri, bulb_bri_auto ? "on" : "off", ls_sensed_brightness);
      if (n < 0 || n >= 255)
      {
        DEBUG_PRINTF("Failed to write status message into buffer\n");
        return false;
      }
      bot.sendMessage(chat_id, msgbuff);
    }
    else if (text == "/on")
    {
      bulb_on = true;
      updated = true;
    }
    else if (text == "/off")
    {
      bulb_on = false;
      updated = true;
    }
    else if (text == "/auto")
    {
      bulb_bri_auto = !bulb_bri_auto;
    }
    else if (text == "/up")
    {
      bulb_bri += 10;
      updated = true;
    }
    else if (text == "/down")
    {
      bulb_bri -= 10;
      updated = true;
    }
    else
    {
      bot.sendMessage(chat_id, "I'm sorry, I don't understand that command.");
    }

    yield();
  }

  bulb_bri = LIMIT_BRIGHTNESS(bulb_bri);
  return updated;
}

const char *params_tmpl = "{\"method\":\"setPilot\",\"params\":{\"state\":%s,\"dimming\":%d}}";

bool udp_write_bulb_set(WiFiUDP udp, bool on, int brightness)
{
  char buffer[128];
  int n = snprintf(buffer, 128, params_tmpl, on ? "true" : "false", brightness);
  if (n < 0 || n >= 128)
  {
    DEBUG_PRINT("Failed to write bulb update into udp buffer\n");
    set_status_led(STATUS_MASK_ERROR);
    return false;
  }

  return udp.write(buffer);
}

void set_status_led(int mask)
{
  led_state_mask = mask;
  digitalWrite(STATUS_LED_RED, mask & 0b00000001 ? HIGH : LOW);
  digitalWrite(STATUS_LED_GREEN, mask & 0b00000010 ? HIGH : LOW);
  digitalWrite(STATUS_LED_BLUE, mask & 0b00000100 ? HIGH : LOW);
}
