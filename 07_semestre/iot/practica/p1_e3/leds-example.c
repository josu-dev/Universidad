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

    while (1)
    {
        PROCESS_YIELD();

        if (ev == PROCESS_EVENT_TIMER && data == &et)
        {
#if LEDS_LEGACY_API
            if ((counter % 3) == 0)
            {
                leds_toggle(LEDS_BLUE);
            }
            if ((counter % 5) == 0)
            {
                leds_toggle(LEDS_RED);
            }
            if ((counter % 7) == 0)
            {
                leds_toggle(LEDS_GREEN);
            }
#else  /* LEDS_LEGACY_API */
            if ((counter % 3) == 0)
            {
                leds_single_toggle(LEDS_LED3);
            }
            if ((counter % 5) == 0)
            {
                leds_single_toggle(LEDS_LED1);
            }
            if ((counter % 7) == 0)
            {
                leds_single_toggle(LEDS_LED2);
            }
#endif /* LEDS_LEGACY_API */

            counter++;
            etimer_set(&et, CLOCK_SECOND);
        }
    }

    PROCESS_END();
}
/*---------------------------------------------------------------------------*/
