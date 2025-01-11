program ejer3;

type
    novela = record
        cod: integer;
        gen: integer;
        nom: string;
        dur: integer;
        dir: string;
        pre: real;
    end;
    file_novelas = file of novela;

procedure leerNovela(var n: novela);
begin
    readln(n.cod);
    if n.cod <> -1 then begin
        readln(n.gen);
        readln(n.nom);
        readln(n.dur);
        readln(n.dir);
        readln(n.pre);
    end;
end;
procedure crearArchivo(f: file_novelas);
var
    fNom: string;
    n: novela;
begin
    write('Nombre para crear archivo de novelas: '); readln(fNom);
    assign(f, fNom);
    rewrite(f);
    n.nro:= 0;
    write(f, n);
    leerNovela(n);
    while(n.nro<>-1)do begin
        write(f, n);
        leerNovela(n);
    end;
    close(f);
end;

procedure altaNovela(var f: file_novelas);
var
    nTemp, nNueva: novela;
begin
    seek(f, 0);
    read(f, nTemp);
    leerNovela(nNueva);
    if (nTemp.cod = 0) then begin
        seek(f, fileSize(f));
        write(f, nNueva);
    end
    else begin
        seek(f, nTemp.cod * -1);
        read(f, nTemp);
        seek(f, filePos(f) -1);
        write(f, nNueva);
        seek(f,0);
        write(f, nTemp);
    end;
end;
procedure modificarNovela(var f: file_novelas);
var
    nTemp, nMod: novela;
begin
    leerNovela(nMod);
    seek(f, 1);
    read(f, nTemp);
    while (nTemp.cod <> nMod.cod) do
        read(f, nTemp);
    seek(f, filePos(f) -1);
    write(f, nMod);
end;
procedure eliminarNovela(var f: file_novelas);
var
    codIngresado: integer;
    nTemp, nEliminado: novela;
begin
    write('Ingrese el codigo de novela a eliminar: '); read(codIngresado);
    seek(f, 0);
    read(f, nTemp);
    read(f, nEliminado);
    while (nEliminado.cod <> codIngresado) do
        read(f, nEliminado);
    nEliminado.cod := nTemp.cod;
    seek(f, filePos(f) -1);
    nTemp.cod := filePos(f) * -1;
    write(f, nEliminado);
    seek(f, 0);
    write(f, nTemp);
end;
procedure mantenimientoArchivo(var f: file_novelas);
var
    fNom: sting;
    opc: char;
begin
    write('Nombre de archivo de novelas a mantener: '); readln(fNom);
    assign(f, fNom);
    reset(f);
    repeat
        writeln('1 - Dar de alta una novela');
        writeln('2 - Modificar novela');
        writeln('3 - Eliminar novela por codigo');
        writeln('0 - Volver al menu principal');
        write('Opcion: '); realn(opc);
        case opc of
            '1' : altaNovela(f);
            '2' : modificarNovela(f);
            '3' : eliminarNovela(f);
            '0' :;
            else begin
                writeln('Ingrese una opcion valida');
                writeln();
            end;
        end;
    until opc = '0'
    close(f);
end;

procedure exportarATxt(var f: file_novelas);
var
    n: novela;
    fTxt: text;
begin
    assign(fTxt, 'novelas.txt');
    rewrite(ftxt)
    reset(f);
    if (not eof(f)) then
        read(f,n);
    while(not eof(f)) begin
        read(f,n);
        writeln(fTxt, n.cod, ' ', n.gen, ' ', n.nom);
        writeln(fTxt, n.dur, ' ', n.pre, ' ', n.dir);
    end;
    close(fTxt);
    close(f);
end;

var
    f: file_novelas;
    opc: char;
begin
    repeat
        writeln('1 - Cargar novelas por teclado');
        writeln('2 - Mantenimiento archivo novelas')
        writeln('3 - Listar novelas en archivo texto')
        write('Opcion: '); readln(opc);
        case opc of
            '1' : crearArchivo(f);
            '2' : mantenimientoArchivo(f);
            '3' : exportarATxt(f);
            '0' : ;
            else begin
                writeln('Ingrese una opcion valida');
                writeln();
            end;
        end;
    until opc = '0';
end;