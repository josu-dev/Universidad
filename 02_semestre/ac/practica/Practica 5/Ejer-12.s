;   El siguiente programa espera usar una subrutina que calcule
;   en forma recursiva el factorial de un número entero:
;           .data
;   valor:  .word 10
;   result: .word 0
;           .text
;           daddi $sp, $zero, 0x400 ; Inicializa puntero al tope de la pila 
;           (1)
;           ld $a0, valor($zero)
;           jal factorial
;           sd $v0, result($zero)
;           halt
;           factorial: ...
;           ...
;           …
;   (1) La configuración inicial de la arquitectura del WinMIPS64
;   establece que el procesador posee un bus de direcciones de 10 bits
;   para la memoria de datos. Por lo tanto, la mayor dirección dentro
;   de la memoria de datos será de 210 = 1024 = 40016.
;
;   a) * Implemente la subrutina factorial definida en forma recursiva.
;   Tenga presente que el factorial de un número 
;   entero n se calcula como el producto de los números enteros entre 1
;   y n inclusive: 
;           factorial(n) = n! = n x (n-1) x (n-2) x … x 3 x 2 x 1
;   b) ¿Es posible escribir la subrutina factorial sin utilizar una pila?
;   Justifique.


                .data
valor:          .word 10
result:         .word 0

                .text
                daddi $sp, $zero, 0x400
                ld $a0, valor($zero)
                jal factorial
                sd $v0, result($zero)
                halt

factorial:      daddi $sp, $sp, -8
                sd $ra, 0($sp)
                daddi $sp, $sp, -8
                sd $a0, 0($sp)
                daddi $a0, $a0, -1
                beq $a0, $0, setUno
                jal factorial
last:           ld $a0, 0($sp)
                daddi $sp, $sp, 8
                ld $ra, 0($sp)
                daddi $sp, $sp, 8
                dmul $v0, $v0, $a0
                jr $ra
setUno:         daddi $v0, $0, 1
                j last
