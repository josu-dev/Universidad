.data
A: .word 4
B: .word 2
C: .word 6
D: .word 0

.code
    ld r1, A(r0)
    ld r2, B(r0)
    ld r3, C(r0)
    ld r4, D(r0)

    daddi r10, r0, 2
    bne r1, r2, COND2
    daddi r4, r4, 1
COND2: bne r1, r3, COND3
    daddi r4, r4, 1
COND3: beq r4, r10, SUM
    bne r2, r3, SUM
    daddi r4, r4, 1
SUM: beqz r4, FIN
    daddi r4, r4, 1
FIN: sd r4, D(r0)
    halt




