#include <ESP8266WiFi.h>
#include <WiFiClientSecure.h>
#include <UniversalTelegramBot.h> // https://github.com/witnessmenow/Universal-Arduino-Telegram-Bot
#include <ArduinoJson.h>

#include "secrets.h"

#define DEBUG 1
#define SERIAL_BAUD 9600

#define LED_ON LOW
#define LED_OFF HIGH
#define LED_PIN 2
#define LOOP_MIN_DELAY 50

#define WIFI_CONNECTION_RETRY_DELAY 1 * 1000

// Telegram

const unsigned long TBOT_SCAN_INTERVAL = 1 * 1000;
const unsigned long TBOT_INFORM_INTERVAL = 5 * 60 * 1000;
const char *const valid_chat_ids[] PROGMEM = {"6853291892", "7416887265"};
const size_t valid_chat_ids_length = sizeof(valid_chat_ids) / sizeof(valid_chat_ids[0]);

X509List cert(TELEGRAM_CERTIFICATE_ROOT);
WiFiClientSecure client;
UniversalTelegramBot bot(TBOT_TOKEN, client);
unsigned long tbot_next_update = 0;
unsigned long tbot_next_inform_state = 0;

// Windows engine

const unsigned long ENGINE_OPERATION_DURATION = 10 * 1000;
unsigned long engine_next_update = 0;
bool engine_is_active = 0;
bool windows_open = 0;
int current_temp = 0;

bool update_windows(unsigned long ts)
{
  if (engine_is_active)
  {
    engine_is_active = 0;
    digitalWrite(LED_PIN, LED_OFF);
  }

  if (current_temp > 30)
  {
    return change_windows(1);
  }

  if (current_temp < 20)
  {
    return change_windows(0);
  }

  return false;
}

bool update_tbot(unsigned long ts)
{
  int updates_count = bot.getUpdates(bot.last_message_received + 1);

  if (updates_count == 0)
  {
    tbot_next_update = ts + TBOT_SCAN_INTERVAL;
    return false;
  }

  while (updates_count)
  {
    tbot_handle_messages(updates_count);
    updates_count = bot.getUpdates(bot.last_message_received + 1);
  }

  tbot_next_update = millis() + TBOT_SCAN_INTERVAL;
  return true;
}

void setup()
{
  Serial.begin(SERIAL_BAUD);

  pinMode(LED_PIN, OUTPUT);
  delay(10);
  digitalWrite(LED_PIN, LED_OFF);

  randomSeed(analogRead(0));

  configTime(0, 0, "pool.ntp.org"); // get UTC time via NTP

  client.setTrustAnchors(&cert);

  WiFi.mode(WIFI_STA);
  WiFi.disconnect();
  delay(100);

  WiFi.setSleep(false); // Allows the WiFi module to enter a low-power state when it is not actively transmitting or receiving data.
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);

  while (WiFi.status() != WL_CONNECTED)
  {
    delay(WIFI_CONNECTION_RETRY_DELAY);
    Serial.println(F("Connecting to WiFi"));
  }

  Serial.println(F("WiFi ready"));
}

void loop()
{
  unsigned long ts = millis();

  current_temp = read_temperature();
  Serial.println(current_temp);

  if (ts > engine_next_update)
  {
    if (update_windows(ts))
    {
      tbot_notify_windows_event(windows_open);
    }
    ts = millis();
  }

  if (ts > tbot_next_update)
  {
    update_tbot(ts);
    ts = millis();
  }

  if (ts > tbot_next_inform_state)
  {
    tbot_inform_state(ts);
  }

  yield(); // Perform background tasks
}

//
// Windows
//

int read_temperature()
{
  return random(50) - 10;
}

bool change_windows(bool should_open)
{
  if (windows_open == should_open)
  {
    return false;
  }

  windows_open = should_open;
  engine_is_active = 1;

  digitalWrite(LED_PIN, LED_ON);

  if (should_open)
  {
    Serial.println(F("Opening windows"));
    // do somehting on activation
  }
  else
  {
    Serial.println(F("Closing windows"));
    // do somehting on deactivation
  }

  engine_next_update = millis() + ENGINE_OPERATION_DURATION;
  return true;
}

//
// Telegram
//

void tbot_handle_messages(int new_messages)
{
  for (int i = 0; i < new_messages; i++)
  {
    String chat_id = bot.messages[i].chat_id;

    if (!is_valid_chat_id(chat_id.c_str()))
    {
      Serial.printf(PSTR("Unauthorized user -> %s\n"), chat_id);
      bot.sendMessage(chat_id, F("Usuario no autorizado 🥲"));
      continue;
    }

    String user_text = bot.messages[i].text;
    Serial.printf(PSTR("Received message -> \"%s\"\n"), user_text);
    String from_name = bot.messages[i].from_name;

    if (user_text == "/start")
    {
      String text =
          F("Hola ") +
          from_name +
          F(", listo para jugar con las ventanas? 😶‍🌫️\n\n"
            "Comandos disponibles:\n\n"
            "*/abrir* - para abrir las ventanas\n"
            "*/cerrar* - para cerrar las ventanas\n"
            "*/vent* - para ver el estado actual de las ventanas\n"
            "*/temp* - para ver la temperatura actual\n");

      bot.sendMessage(chat_id, text, F("Markdown"));
      continue;
    }

    if (user_text == "/abrir")
    {
      if (windows_open)
      {
        bot.sendMessage(chat_id, F("Las ventanas ya estan abiertas"));
        continue;
      }

      if (engine_is_active)
      {
        bot.sendMessage(chat_id, F("Las ventanas se estan cerrando, espere"));
        continue;
      }

      if (change_windows(1))
      {
        bot.sendMessage(chat_id, F("Abriendo ventanas"));
        continue;
      }

      bot.sendMessage(chat_id, F("No se puede abrir las ventanas ahora"));
      continue;
    }

    if (user_text == "/cerrar")
    {
      if (!windows_open)
      {
        bot.sendMessage(chat_id, F("Las ventanas ya estan cerradas"));
        continue;
      }

      if (engine_is_active)
      {
        bot.sendMessage(chat_id, F("Las ventanas se estan abriendo, espere"));
        continue;
      }

      if (change_windows(0))
      {
        bot.sendMessage(chat_id, F("Cerrando ventanas"));
        continue;
      }

      bot.sendMessage(chat_id, F("No se puede cerrar las ventanas ahora"));
      continue;
    }

    if (user_text == "/temp")
    {
      bot.sendMessage(chat_id, F("La temperatura es ") + String(current_temp) + "°C");
      continue;
    }

    if (user_text == "/vent")
    {
      String message;
      if (engine_is_active)
      {
        message = F("Las ventanas se estan ") + String(windows_open ? "abriendo" : "cerrando");
      }
      else
      {
        message = F("Las ventanas estan ") + String(windows_open ? "abiertas" : "cerradas");
      }

      bot.sendMessage(chat_id, message);
      continue;
    }

    Serial.printf(PSTR("Unknown command -> %s\n"), user_text);
    bot.sendMessage(chat_id, F("Comando no reconocido"));
  }
}

void tbot_notify_windows_event(bool open)
{
  for (size_t i = 0; i < valid_chat_ids_length; i++)
  {
    bot.sendMessage(
        (const char *)pgm_read_ptr(&valid_chat_ids[i]),
        F("Las ventanas se estan ") + String(open ? "abriendo " : "cerrando ") + "(" + String(current_temp) + "°C)");
  }
}

void tbot_inform_state(unsigned long ts)
{
  for (size_t i = 0; i < valid_chat_ids_length; i++)
  {
    bot.sendMessage(
        (const char *)pgm_read_ptr(&valid_chat_ids[i]),
        F("*Estado actual:*\n\n- Temperatura: ") +
            String(current_temp) + "°C\n" +
            F("- Ventanas: ") + String(windows_open ? "abiertas" : "cerradas") + "\n" +
            F("- Motor: ") + (engine_is_active ? "funcionando" : "apagado"),
        "Markdown");
  }

  tbot_next_inform_state = ts + TBOT_INFORM_INTERVAL;
}

bool is_valid_chat_id(const char *chat_id)
{
  for (size_t i = 0; i < valid_chat_ids_length; i++)
  {
    if (strcmp_P(chat_id, (const char *)pgm_read_ptr(&valid_chat_ids[i])) == 0)
    {
      return true;
    }
  }
  return false;
}

//
// Others
//
