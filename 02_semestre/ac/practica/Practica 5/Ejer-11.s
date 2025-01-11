;   Escribir una subrutina que reciba como argumento una tabla de
;   números terminada en 0. La subrutina debe contar la 
;   cantidad de números que son impares en la tabla, esta condición
;   se debe verificar usando una subrutina es_impar. La 
;   subrutina es_impar debe devolver 1 si el número es impar y 0
;   si no lo es.

                .data
TABLA:          .word 9889, 4233, 321, 3233, 888, 0

                .code
                j main

es_impar:       andi $v0, $a0, 1
                jr $ra

contar_impares: dadd $s0, $a0, $0
                daddi $s1, $0, -8
                dadd $s7, $ra, $0
loop:           daddi $s1, $s1, 8
                ld $a0, 0($s1)
                beq $a0, $0, end
                jal es_impar
                beq $v0, $0, loop
                daddi $s2, $s2, 1
                j loop
end:            dadd $ra, $s7, $0
                dadd $v0, $s2, $0
                jr $ra


main:           daddi $a0, $0, TABLA
                jal contar_impares
halt