program ejer2;
const
    CORTE_CARGA = -1;
    MARCA_BORRADO = '!';

type
    asistente = record
        nro : integer;
        apeynom: string;
        email: string;
        tel:integer;
        dni:integer;
    end;

    file_asistentes = file of asistente;

procedure leerAsistente(var a: asistente);
begin
    readln(a.nro);
    if a.nro <> CORTE_CARGA then begin
        readln(a.apeynom);
        readln(a.email);
        readln(a.tel);
        readln(a.dni);
    end;
end;
procedure generarArchivo(var f: file_asistentes);
var
    a: asistente;
begin
    rewrite(f);
    leerAsistente(a);
    while a.nro <> CORTE_CARGA do begin
        write(f,a);
        leerAsistente(a);
    end;
    close(f);
end;


procedure eliminarMenores(var f:file_asistentes; nro:integer);
var
    a: asistente;
begin
    reset(f);
    while (not eof(f)) do begin
        read(f,a);
        if a.nro< nro then begin
            a.apeynom := MARCA_BORRADO + a.apeynom
            seek(f, filePos(f)-1);
            write(f, a);
        end;
    end;
    close(f);
end;

var
    f: file_asistentes;
begin
    assign(f, 'ejer2Asistentes');
    generarArchivo(f);
    eliminarMenores(f, 1000);
end.