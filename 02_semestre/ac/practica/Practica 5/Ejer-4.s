;   El índice de masa corporal (IMC) es una medida de asociación
;   entre el peso y la talla de un individuo.
;   Se calcula a partir del peso (expresado en kilogramos,
;   por ejemplo: 75,7 kg) y la estatura (expresada en metros, por 
;   ejemplo 1,73 m), usando la fórmula:
;                                       IMC = peso / (estatura)^2
;
;   De acuerdo al valor calculado con este índice, puede clasificarse
;   el estado nutricional de una persona en:
;                                           Infrapeso (IMC < 18,5)
;                                           Normal (18,5 ≤ IMC < 25)
;                                           Sobrepeso (25 ≤ IMC < 30)
;                                           Obeso (IMC ≥ 30).
;   Escriba un programa que dado el peso y la estatura de una persona
;   calcule su IMC y lo guarde en la dirección etiquetada IMC.
;   También deberá guardar en la dirección etiquetada estado un valor
;   según la siguiente tabla:

        .data
PESO:   .double 60
ALTURA: .double 1.84
IMC:    .double 0
estado: .word 0
Cla1:   .double 18.5
Cla2:   .double 25
Cla3:   .double 30

        .code
        l.d f2, ALTURA(r0)
        l.d f1, PESO(r0)

        mul.d f3, f2, f2
        div.d f3, f1, f3
        s.d f3, IMC(r0)

        l.d f4, Cla1(r0)
        c.lt.d f3, f4
        bc1f JUMP1
        daddi r1, r0, 1
        j actEstado
JUMP1:  l.d f4, Cla2(r0)
        c.lt.d f3, f4
        bc1f JUMP2
        daddi r1, r0, 2
        j actEstado
JUMP2:  l.d f4, Cla3(r0)
        c.lt.d f3, f4
        bc1f JUMP3
        daddi r1, r0, 3
        j actEstado
JUMP3:  daddi r1, r0, 4

actEstado: sd r1, estado(r0)
        halt
