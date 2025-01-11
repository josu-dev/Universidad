;   Escribir un programa que multiplique dos números enteros
;   utilizando sumas repetidas (similar a Ejercicio 6 o 7 de la Práctica 
;   1). El programa debe estar optimizado para su ejecución con la opción
;   Delay Slot habilitada

        .data
N1:     .word 5
N2:     .word 9
RES:    .word 0

        .code
        ld r2, N2(r0)
        ld r1, N1(r0)

        beqz r2, FIN
        beqz r1, FIN
LOOP:   daddi r2, r2, -1
        dadd r3, r3, r1
        bnez r2, LOOP
FIN:    sd r3, RES(r0)
        halt
