;   Escriba una subrutina que reciba como parámetros las direcciones
;   del comienzo de dos cadenas terminadas en cero y 
;   retorne la posición en la que las dos cadenas difieren. En caso
;   de que las dos cadenas sean idénticas, debe retornar -1.

            .data
STR1:       .asciiz "tuViejaEn3"
STR2:       .asciiz "tuViejaEn3"

            .code
            j main

equals:     daddi $t0, $0, -1
loop:       daddi $t0, $t0, 1
            lbu $t1, 0($a0)
            lbu $t2, 0($a1)
            daddi $a0, $a0, 1
            daddi $a1, $a1, 1
            beq $t1, $0, last
            beq $t2, $0, last
            beq $t1, $t2, loop
last:       beq $t1, $t2, retEqual
            dadd $v0, $0, $t0
            jr $ra
retEqual:   daddi $v0, $0, -1
            jr $ra




main:       daddi $a0, $0, STR1
            daddi $a1, $0, STR2
            jal equals
halt
