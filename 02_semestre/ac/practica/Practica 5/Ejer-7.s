;   Escriba una subrutina que reciba como parámetros un número
;   positivo M de 64 bits, la dirección del comienzo de una 
;   tabla que contenga valores numéricos de 64 bits sin signo y
;   la cantidad de valores almacenados en dicha tabla.
;   La subrutina debe retornar la cantidad de valores mayores
;   que M contenidos en la tabla.

            .data
M:          .word 7637
TABLA:      .word 0, 8382, 9654699, 15000
TAM:        .word 4
CANT:       .word 0

            .code
            j main
esMayor:    daddi $v0, $zero, 0
loop:       beq $t0, $a2, fin
            daddi $t0, $t0, 1
            ld $t2, 0($a1)
            slt $t1, $a0, $t2
            daddi $a1, $a1, 8
            beq $t1, $zero, loop
            daddi $v0, $v0, 1
            j loop
fin:        jr $ra


main:       ld $a0, M($zero)
            daddi $a1, $zero, TABLA
            ld $a2, TAM($zero)
            jal esMayor
            sd $v0, CANT($zero)
            halt