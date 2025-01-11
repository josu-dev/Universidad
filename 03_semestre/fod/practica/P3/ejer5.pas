program ejer5;

procedure eliminarFlor(var a: tArchFlores; flor: reg_flor);
var
    florTemp: reg_flor;
begin
    reset(a);
    read(a, florTemp);
    while(florTemp.codigo <> flor.codigo) do
        read(a, florTemp);
    florTemp.codigo := filePos(f) -1;
    seek(f, 0);
    read(f, flor);
    seek(f, florTemp.codigo);
    write(f, flor);
    seek(f, 0);
    florTemp.codigo := florTemp.codigo * -1;
    write(f, florTemp);
    close(a);
end;