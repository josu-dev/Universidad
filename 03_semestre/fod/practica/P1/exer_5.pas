program exer_5;

const
    NOM_DEFAULT = 'celulares.txt';


type
    celular = record
        cod: integer;
        nom: string;
        desc: string;
        marca: string;
        precio: real;
        stock_min: integer;
        stock: integer;
    end;

    File_Celular = file of celular;

procedure cargarCelulares(var f: File_Celular);
var
    nombre: string;
    fTxt: TextFile;
    c: celular;
begin
    write('Ingrese el nombre del nuevo archivo: '); readln(nombre);
    assign(f, nombre);
    rewrite(f);
    assign(fTxt, NOM_DEFAULT);
    reset(fTxt);
    while (not eof(fTxt)) do begin
        readln(fTxt, c.cod, c.precio, c.marca);
        readln(fTxt, c.stock, c.stock_min, c.desc);
        readln(fTxt, c.nom);
        write(f, c);
    end;
    close(fTxt);
    close(f);
end;

procedure imprimirCelular(c: celular);
begin
    writeln('Codigo: ', c.cod);
    writeln('Nombre: ', c.nom);
    writeln('Descripcion: ', c.desc);
    writeln('Marca: ', c.marca);
    writeln('Precio: ', c.precio);
    writeln('Stock_min: ', c.stock_min);
    writeln('Stock: ', c.stock);
end;

procedure listarPocoSock(var f: File_Celular);
var
    c: celular;
begin
    writeln('Los celulares con falta de stock son:');
    reset(f);
    while (not eof(f)) do begin
        read(f, c);
        if (c.stock < c.stock_min) then
            imprimirCelular(c);
    end;
    close(f);
end;

procedure listarPorCadena(var f: File_Celular);
var
    c: celular;
    cadena: string;
begin
    write('Ingrese cadena a buscar: '); readln(cadena);
    writeln('Los celulares con la cadena ', cadena, 'en su descripcion son:');
    reset(f);
    while (not eof(f)) do begin
        read(f, c);
        if (pos(cadena, c.desc) > 0) then
            imprimirCelular(c);
    end;
    close(f);
end;

procedure exportarArchivo(var f: File_Celular);
var
    c: celular;
    newFText: TextFile;
begin
    assign(newFText, NOM_DEFAULT);
    rewrite(newFText);
    reset(f);
    while (not eof(f)) do begin
        read(f, c);
        writeln(newFText, c.cod, c.precio, c.marca);
        writeln(newFText, c.stock, c.stock_min, c.desc);
        writeln(newFText, c.nom);
    end;
    close(f);
    close(newFText);
end;

var
    f: File_Celular;
begin
    cargarCelulares(f);
    listarPocoSock(f);
    listarPorCadena(f);
end.
