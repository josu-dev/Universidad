        .data
TABLA:  .word 1,2, 3, 4, 5, 6, 7, 8, 9, 10
X:      .word 3
CANT:   .word 0
RES:    .word 0

        .code
        daddi r10, r0, -8
        daddi r11, r0, 80
        ld r1, X(r0)
        daddi r4, r0, 1
        ld r5, CANT(r0)

LOOP:   daddi r10, r10, 8
        beq r10, r11, FIN
        ld r2, TABLA(r10)
        slt r3, r1, r2
        bne r3, r4, LOOP
        daddi r5, r5, 1
        sd r4, RES(r10)
        j LOOP
FIN:    sd r5, CANT(r0)
        halt
