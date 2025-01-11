#include "contiki.h"
#include "dev/leds.h"
#include "sys/etimer.h"

#include <stdio.h>
/*---------------------------------------------------------------------------*/
static struct etimer et;
static uint8_t counter;
/*---------------------------------------------------------------------------*/
PROCESS(leds_example, "LED HAL Example");
AUTOSTART_PROCESSES(&leds_example);
/*---------------------------------------------------------------------------*/
PROCESS_THREAD(leds_example, ev, data)
{
  PROCESS_BEGIN();

  counter = 0;

  etimer_set(&et, CLOCK_SECOND);

  while(1) {

    PROCESS_YIELD();

    if(ev == PROCESS_EVENT_TIMER && data == &et) {
      if((counter & 7) == 0) {
        leds_set(LEDS_ALL);
      } else if((counter & 7) == 1) {
        leds_off(LEDS_ALL);
      } else if((counter & 7) == 2) {
        leds_on(LEDS_ALL);
      } else if((counter & 7) == 3) {
        leds_toggle(LEDS_ALL);
#if LEDS_LEGACY_API
      } else if((counter & 7) == 4) {
        leds_on(LEDS_RED);
      } else if((counter & 7) == 5) {
        leds_off(LEDS_RED);
      } else if((counter & 7) == 6) {
        leds_toggle(LEDS_RED);
#else /* LEDS_LEGACY_API */
      } else if((counter & 7) == 4) {
        leds_single_on(LEDS_LED1);
      } else if((counter & 7) == 5) {
        leds_single_off(LEDS_LED1);
      } else if((counter & 7) == 6) {
        leds_single_toggle(LEDS_LED1);
#endif /* LEDS_LEGACY_API */
      } else if((counter & 7) == 7) {
        leds_toggle(LEDS_ALL);
      }

      counter++;
      etimer_set(&et, CLOCK_SECOND);
    }
  }

  PROCESS_END();
}
/*---------------------------------------------------------------------------*/
