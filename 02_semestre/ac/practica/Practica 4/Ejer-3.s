    .data
A: .word 1
B: .word 3
ARRAY: .word 0

    .code
    ld r2, B(r0)
    ld r1, A(r0)
    daddi r3, r0, -8
loop: dsll r1, r1, 1
    daddi r3, r3, 8
    daddi r2, r2, -1
    sd r1, ARRAY(r3)
    bnez r2, loop
    nop
    halt