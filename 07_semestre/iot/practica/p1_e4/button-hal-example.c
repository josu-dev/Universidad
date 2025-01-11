#include "contiki.h"
#include "dev/leds.h"
#include "dev/button-hal.h"
#include "sys/etimer.h"

#include <stdio.h>

/* Timer */
static struct etimer et;
static uint8_t counter;
static uint8_t enabled, active;

/* Process */
PROCESS(ejercicio_4, "Practica 1 - Ejercicio 4");
AUTOSTART_PROCESSES(&ejercicio_4);

PROCESS_THREAD(ejercicio_4, ev, data)
{
    button_hal_button_t *btn;

    PROCESS_BEGIN();

    counter = 0;
    enabled = 0;
    active = 0;

    btn = button_hal_get_by_index(0);

    if (btn)
    {
        printf("%s on pin %u with ID=0, Logic=%s, Pull=%s\n",
               BUTTON_HAL_GET_DESCRIPTION(btn), btn->pin,
               btn->negative_logic ? "Negative" : "Positive",
               btn->pull == GPIO_HAL_PIN_CFG_PULL_UP ? "Pull Up" : "Pull Down");
    }

    etimer_set(&et, CLOCK_SECOND);

    while (1)
    {
        PROCESS_YIELD();

        if (ev == button_hal_press_event)
        {
            // btn = (button_hal_button_t *)data;
            enabled = enabled ^ 1;
        }
        else if (ev == PROCESS_EVENT_TIMER && data == &et)
        {
            if (enabled)
            {
                if ((counter % 3) == 0)
                {
                    leds_single_toggle(LEDS_LED3);
                    active = active ^ 0b100;
                }
                if ((counter % 5) == 0)
                {
                    leds_single_toggle(LEDS_LED1);
                    active = active ^ 0b001;
                }
                if ((counter % 7) == 0)
                {
                    leds_single_toggle(LEDS_LED2);
                    active = active ^ 0b010;
                }
            }
            else if (active)
            {
                if ((active & 0b100) && (counter % 3) == 0)
                {
                    leds_single_off(LEDS_LED3);
                    active = active ^ 0b100;
                }
                if ((active & 0b001) && (counter % 5) == 0)
                {
                    leds_single_off(LEDS_LED1);
                    active = active ^ 0b001;
                }
                if ((active & 0b010) && (counter % 7) == 0)
                {
                    leds_single_off(LEDS_LED2);
                    active = active ^ 0b010;
                }
            }

            counter++;
            etimer_set(&et, CLOCK_SECOND);
        }
    }

    PROCESS_END();
}
