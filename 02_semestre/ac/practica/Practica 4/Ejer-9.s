;   Escribir un programa que implemente el siguiente fragmento escrito
;   en un lenguaje de alto nivel:
;   while a > 0 do
;   begin
;       x := x + y;
;       a := a - 1;
;   end;
;   Ejecutar con la opción Delay Slot habilitada.

        .data
x:      .word 8
y:      .word 8
a:      .word 8

        .code
        ld r10, a(r0)
        ld r1, x(r0)
        ld r2, y(r0)

while:   beqz r10, end
        nop
        dadd r1, r1, r2
        daddi r10, r10, -1
        j while
        nop
end:    halt