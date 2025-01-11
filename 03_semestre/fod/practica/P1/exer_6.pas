program exer_5;

const
    NOM_DEFAULT = 'celulares.txt';


type
    celular = record
        cod: string;
        nom: string;
        desc: string;
        marca: string;
        precio: real;
        stock_min: integer;
        stock: integer;
    end;

    File_Celular = file of celular;

function askToContinue(s: string): boolean;
var
    r: string;
begin
    writeln(s);
    writeln('Ingrese Si | No');
    readln(r);
    askToContinue := (r = 's') or (r = 'S') or (r = 'si') or (r = 'sI') or (r= 'Si') or (r='SI');
end;

procedure cargarCelulares(var f: File_Celular);
var
    nombre: string;
    fTxt: TextFile;
    c: celular;
begin
    write('Ingrese el nombre del nuevo archivo'); readln(nombre);
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

procedure leerCelular(c: celular);
begin
    writeln('Codigo: '); readln(c.cod);
    writeln('Nombre: '); readln(c.nom);
    writeln('Descripcion: '); readln(c.desc);
    writeln('Marca: '); readln(c.marca);
    writeln('Precio: '); readln(c.precio);
    writeln('Stock_min: '); readln(c.stock_min);
    writeln('Stock: '); readln(c.stock);
end;

procedure aniadirCelulares(var f: File_Celular);
var
    c:celular;
    bContinue: boolean;
begin
    reset(f);
    repeat
        leerCelular(c);
        seek(f, sizeof(f) -1);
        write(f, c);
        bContinue := askToContinue('Quiere añadir otro trabajador?');
    until not bContinue;
    close(f);
end;

procedure buscarPorNombre(var f: File_Celular; nom: string; var c:celular);
var
    finded: boolean;
begin
    finded:= false;
    seek(f, 0);
    while (not eof(f) and not finded) do begin
        read(f, c);
        finded := c.nom = nom;
    end;
end;

procedure modificarCelular(var f: File_Celular);
var
    c: celular;
    nombre: string;
    stock: integer;
begin
    write('Ingrese el nombre del trabajador a modificar: '); readln(nombre);
    write('Ingrese el nuevo stock: '); readln(stock);
    reset(f);
    buscarPorNombre(f, nombre, c);
    c.stock := stock;
    seek(f, filePos(f) - 1);
    write(f, c);
    close(f);
end;
    
procedure exportarStock0(var f: File_Celular);
var
    c: celular;
    newFText: TextFile;
begin
    assign(newFText, 'SinStock.txt');
    rewrite(newFText);
    reset(f);
    while (not eof(f)) do begin
        read(f,c);
        if (c.stock = 0) then begin
            writeln(newFText, c.cod, c.precio, c.marca);
            writeln(newFText, c.stock, c.stock_min, c.desc);
            writeln(newFText, c.nom);
        end;
    end;
    close(f);
    close(newFText);
end;

var
    f: File_Celular;
    opc: char;
    bApp: boolean;
begin
    bApp := true;
    cargarCelulares(f);
    while bApp do begin
        writeln('Ingrese la opcion a elegir:');
        writeln('   1- Listar por bajo stock');
        writeln('   2- Listar por cadena en descripcion');
        writeln('   3- Exportar a .txt todos');
        writeln('   4- Añadir uno o mas celulares');
        writeln('   5- Modificar un celular');
        writeln('   6- Exportar a .txt empleados sin stock');
        writeln('   0- Finalizar programa');
        write('Opcion: '); readln(opc);

        case opc of
            '1' : listarPocoSock(f);
            '2' : listarPorCadena(f);
            '3' : exportarArchivo(f);
            '4' : aniadirCelulares(f);
            '5' : modificarCelular(f);
            '6' : exportarStock0(f);
            '0' : bApp := false;
            else writeln('Opcion no valida');
        end;

        if (bApp) then begin
            write('Presione enter para continuar '); readln();
        end;
    end;
end.