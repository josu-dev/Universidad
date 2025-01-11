program exer1;

type
    comision = record
        cod : integer;
        nom : string;
        monto : real;
    end;

    file_comisiones = file of comision;

procedure leerComision(var f: file_comisiones; var c: comision);
begin
    if (eof(f))
        c.cod := -1
    else
        read(f, c);
end;

procedure compactarComisiones(var fBase: file_comisiones);
var
    fComp: file_comisiones;
    c, cTotal: comision;
begin
    assign(fComp, 'comisiones_compactadas');
    rewrite(fComp);
    reset(fBase);
    leerComision(fBase, c);
    while (c.cod <> -1) do begin
        cTotal.cod = c.cod;
        cTotal.monto = 0;
        cTotal.nom = c.nom;
        while (c.cod <> -1) & (c.cod = cTotal.cod) do begin
            cTotal.monto += c.monto;
            leerComision(fBase, c);
        end;
        write(fComp, cTotal)
    end;
    close(fBase);
    close(fComp);
end;