;   Escribir un programa que cuente la cantidad de veces que un
;   determinado caracter aparece en una cadena de texto. Observar 
;   cómo se almacenan en memoria los códigos ASCII de los caracteres
;   (código de la letra “a” es 61H). Utilizar la instrucción lbu 
;   (load byte unsigned) para cargar códigos en registros.
;   La inicialización de los datos es la siguiente:
;   .data
;   cadena: .asciiz "adbdcdedfdgdhdid" ; cadena a analizar
;   car: .asciiz "d" ; caracter buscado
;   cant: .word 0 ; cantidad de veces que se repite el
;                 ; caracter car en cadena.

        .data
cadena: .asciiz "adbdcdedfdgdhdid"
car:    .asciiz "d"
cant:   .word 0


        .code
        lbu r1, car(r0)
load:   lbu r2, cadena(r10)
        daddi r10, r10, 1
        beqz r2, fin
        nop
        bne r1, r2, load
        nop
        daddi r3, r3, 1
        j load
        nop
fin:    sd r3, cant(r0)
        halt