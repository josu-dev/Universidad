program exer_7;

const
    SRC_NAME = 'novelas.txt';
    B_NAME = 'novelas';

type
    Novela = record
        cod : integer;
        pre : real;
        gen : string;
        nom : string;
    end;

    File_Novela = file of Novela;

procedure loadAndCreateFile(var f: File_Novela);
var
    n: novela;
    tF: TextFile;
begin
    assign(tF, SRC_NAME);
    assign(f, B_NAME);
    reset(tF);
    rewrite(f);
    while (not eof(tF)) do begin
        readln(tF, n.cod, n.pre, n.gen);
        readln(tF, n.nom);
        write(f, n);
    end;
    close(tF);
    close(f);
end;

procedure searchByCod(var f: File_Novela; c: integer; var n: novela);
var
    finded: boolean;
begin
    finded:= false;
    seek(f, 0);
    while (not eof(f) and not finded) do begin
        read(f, n);
        finded := n.cod = c;
    end;
end;

procedure readNovela(var n: novela);
begin
    writeln('Ingrese los datos de la nueva novela:');
    write('Codigo: '); readln(n.cod);
    write('Precio: '); readln(n.pre);
    write('Genero: '); readln(n.gen);
    write('Nombre: '); readln(n.nom);
end;
procedure addNovela(var f: File_Novela);
var
    n: novela;
begin
    readNovela(n);
    reset(f);
    seek(f, fileSize(f));
    write(f, n);
    close(f);
end;
procedure modifyNovela(var f: File_Novela);
var
    n: novela;
    c: integer;
begin
    write('Ingrese el codigo de la novela a modificar: '); readln(c);
    reset(f);
    searchByCod(f,c,n);
    readNovela(n);
    seek(f, filePos(f) - 1);
    write(f, n);
    close(f);
end;

var
    f: File_Novela;
begin
    loadAndCreateFile(f);
    addNovela(f);
    modifyNovela(f);
end.