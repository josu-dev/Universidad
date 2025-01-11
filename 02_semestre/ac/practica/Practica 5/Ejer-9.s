;   Escriba la subrutina ES_VOCAL, que determina si un carácter
;   es vocal o no, ya sea mayúscula o minúscula. La rutina 
;   debe recibir el carácter y debe retornar el valor 1 si el
;   carácter es una vocal, o 0 en caso contrario

            .data
VOCALES:    .asciiz "AEIOUaeiou"
CHAR:       .asciiz "U"

            .code
            j main
            
ES_VOCAL:   daddi $t0, $0, -1
loop:       daddi $t0, $t0, 1
            lbu $t1, VOCALES($t0)
            beq $t1, $0, noEs
            bne $t1, $a0, loop
siEs:       daddi $v0, $0, 1
            jr $ra
noEs:       daddi $v0, $0, 0 
            jr $ra


main:       lbu $a0, CHAR($0)
            jal ES_VOCAL
halt