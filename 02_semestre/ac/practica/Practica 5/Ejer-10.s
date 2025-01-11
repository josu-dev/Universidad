;   Usando la subrutina escrita en el ejercicio anterior, escribir
;   la subrutina CONTAR_VOC, que recibe una cadena 
;   terminada en cero , y devuelve la cantidad de vocales que tiene
;   esa cadena.

            .data
VOCALES:    .asciiz "AEIOUaeiou"
STR:        .asciiz "pepItoxd"

            .code
            j main
            
ES_VOCAL:   daddi $t0, $0, -1
loop1:       daddi $t0, $t0, 1
            lbu $t1, VOCALES($t0)
            beq $t1, $0, noEs
            bne $t1, $a0, loop1
siEs:       daddi $v0, $0, 1
            jr $ra
noEs:       daddi $v0, $0, 0 
            jr $ra

CONTAR_VOC: daddi $s0, $0, -1
            dadd $s1, $0, $a0
            dadd $s3, $ra, $0
loop2:      daddi $s0, $s0, 1
            lbu $a0, 0($s1)
            beq $a0, $0, ret
            daddi $s1, $s1, 1
            jal ES_VOCAL
            beq $v0, $0, loop2
            daddi $s2, $s2, 1
            j loop2
ret:        dadd $v0, $0, $s2 
            dadd $ra, $s3, $0
            jr $ra


main:       daddi $a0, $0, STR
            jal CONTAR_VOC
halt