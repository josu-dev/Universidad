;   Implementar  una subrutina INGRESAR_NUMERO. La misma deberá solicitar
;   el ingreso por teclado de un número entero del 1 al 9. Si el número
;   ingresado es  un número válido entre 1 y 9 la subrutina deberá imprimir
;   por pantalla el número ingresado y retornar dicho valor. En caso contrario,
;   la subrutina deberá  imprimir por pantalla  “Debe ingresar un número”
;   y devolver el valor 0. 

;   Usando la subrutina INGRESAR_NUMERO implementar un programa que invoque
;   a dicha subrutina y genere una tabla llamada NUMEROS con los valores
;   ingresados. La generación de la tabla finaliza cuando la suma de los
;   resultados obtenidos  sea mayor o igual a los últimos 3 dígitos de su
;   número mágico.  

;   Al finalizar la generación de la tabla, deberá invocar a la subrutina
;   PROCESAR_NUMEROS.  

;   Se debe usar la convención para nombrar a los registros. 

;   Para todos los casos, la subrutina PROCESAR_NUMEROS debe devolver el
;   valor calculado y desde el programa principal el mismo se debe almacenar
;   en la dirección RESULTADO.
;   SI SU NUMERO MÁGICO TERMINA CON  3 o 4: la subrutina PROCESAR_NUMEROS
;   debe recibir como parámetro la dirección de la tabla NUMEROS y la cantidad
;   de elementos y  contar la cantidad de números pares ingresados. Se debe
;   mostrar por pantalla el valor calculado, con el texto "Cantidad de Valores
;   pares: “ y el valor.


                    .data
CONTROL:            .word32 0x10000
DATA:               .word32 0x10008
MINGRESO:           .asciiz "Ingrese un numero del 1 al 9: "
MERROR:             .asciiz "Debe Ingresar un numero\n"
NUM:                .asciiz " \n"
MPARES:             .asciiz " \nCantidad de Valores pares: "
NUMMAGICO:          .word 713
RESULTADO:          .word 0
NUMEROS:            .byte 0


                    .text
                    lwu $s6, CONTROL($0)
                    lwu $s7, DATA($0)
                    daddi $s4, $0, 4
                    daddi $s5, $0, 9


                    ld $s0, NUMMAGICO($0)
                    dadd $s1, $0, $0
                    dadd $s2, $0, $0

NUMEROSLoop:        slt $t0, $s1, $s0
                    beqz $t0, NUMEROSFin
                    jal INGRESAR_NUMERO
                    beqz $v0, NUMEROSLoop
                    sb $v0, NUMEROS($s2)
                    dadd $s1, $s1, $v0
                    daddi $s2, $s2, 1
                    j NUMEROSLoop

NUMEROSFin:         daddi $a0, $0, NUMEROS
                    dadd $a1, $0, $s2
                    jal PROCESAR_NUMEROS
                    ld $v0, RESULTADO($0)
halt

INGRESAR_NUMERO:    daddi $t0, $0, MINGRESO
                    sd $t0, 0($s7)
                    sd $s4, 0($s6)
                    sd $s5, 0($s6)

                    lbu $t1, 0($s7)
                    slti $t0, $t1, 49
                    bnez $t0, INError
                    slti $t0, $t1, 58
                    beqz $t0, INError

                    sb $t1, NUM($0)
                    daddi $t0, $0, NUM
                    sd $t0, 0($s7)
                    sd $s4, 0($s6)
                    daddi $v0, $t1, -48
                    jr $ra
INError:            daddi $t0, $0, MERROR
                    sd $t0, 0($s7)
                    sd $s4, 0($s6)
                    daddi $v0, $0, 0
                    jr $ra

PROCESAR_NUMEROS:   dadd $v0, $0, $0
PNLoop:             beqz $a1, PNRet
                    lbu $t1, 0($a0)
                    daddi $a1, $a1, -1
                    andi $t0, $t1, 1
                    daddi $a0, $a0, 1
                    beqz $t0, PNPar
                    j PNLoop
PNPar:              daddi $v0, $v0, 1
                    j PNLoop
PNRet:              daddi $t0, $0, MPARES
                    sd $t0, 0($s7)
                    sd $s4, 0($s6)
                    sd $v0, 0($s7)
                    daddi $t0, $0, 1
                    sd $t0, 0($s6)
                    jr $ra

