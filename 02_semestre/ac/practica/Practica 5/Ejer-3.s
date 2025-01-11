;   Escribir un programa que calcule la superficie de un
;   triángulo rectángulo de base 5,85 cm y altura 13,47 cm

        .data
BASE:   .double 5.85
ALTURA: .double 13.47
DOS:    .double 2
SUP:    .double 0

        .code
        l.d f1, BASE(r0)
        l.d f2, ALTURA(r0)
        l.d f3, DOS(r0)
        mul.d f1, f1, f2
        div.d f1, f1, f3
        s.d f1, SUP(r0)
        halt