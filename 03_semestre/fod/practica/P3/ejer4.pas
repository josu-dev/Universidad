program ejer4;

type
    reg_flor = record
        nombre: String[45];
        codigo: integer;
    end;
    tArchFlores = file of reg_flor;

procedure agregarFlor(var a: tArchFlores; nombre: string[45]; codigo: integer);
var
    fTmp: reg_flor;
    fNue: reg_flor;
begin
    fNue.codigo:= codigo;
    fNue.nombre:= nombre;
    reset(a);
    read(f, fTmp);
    if (fTemp.codigo = 0) then begin
        seek(f, fileSize(f));
        write(f,fNue);
    end
    else begin
        seek(f, fTemp.codigo * -1);
        read(f, fTemp);
        seek(f, filePos(f) -1);
        write(f,fNue);
        seek(f, 0);
        write(f, fTemp);
    end;
    close(a);
end;

procedure listarValidos(var a: tArchFlores);
var
    f: reg_flor;
begin
    reset(a);
    while(not eof(a)) do begin
        read(a,f);
        if f.codigo > 0 then
            writeln('Nombre: ', f.nombre,', codigo: ', f.codigo);
    end;
    close(a);
end;