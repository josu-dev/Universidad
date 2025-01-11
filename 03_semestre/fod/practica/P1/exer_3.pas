program exer_3;
const
    APE_CORTE = 'fin';
    AGE_COMP = 70;
type
    Worker = record
        num: integer;
        ape: string;
        nom: string;
        edad: integer;
        dni: string;
    end;

    File_Worker = file of Worker;

procedure readWorker(var w: Worker);
begin
    write('Ingrese apellido: ');
    readln(w.ape);
    if (w.ape <> APE_CORTE) then begin
        write('Ingrese nombre: ');
        readln(w.nom);
        write('Ingrese numero: ');
        readln(w.num);
        write('Ingrese edad: ');
        readln(w.edad);
        write('Ingrese dni: ');
        readln(w.dni);
    end;
end;
procedure createFile(var f: File_Worker);
var
    name: string;
    w: Worker;
begin
    write('Enter name for the new worker list: ');
    readln(name);
    assign(f, name);
    rewrite(f);
    readWorker(w);
    while (w.ape <> APE_CORTE) do begin
        write(f, w);
        readWorker(w);
    end;
    close(f);
end;


procedure processFileByNameOrSurname(var f: File_Worker; id: string);
var
    w: Worker;
begin
    writeln('Empleados registrados como ', id, ':');
    reset(f);
    while (not eof(f)) do begin
        read(f,w);
        if ((w.ape = id) or (w.nom = id)) then begin
            writeln(w.num);
            writeln(w.nom);
            writeln(w.ape);
            writeln(w.dni);
            writeln(w.edad);
        end;
    end;
    close(f);
end;

procedure processFileInLine(var f: File_Worker);
var
    w: Worker;
begin
    writeln('Todos los empleados:');
    reset(f);
    while (not eof(f)) do begin
        read(f,w);
        writeln(w.num, ', ',w.nom, ', ',w.ape, ', ',w.dni, ', ',w.edad);
    end;
    close(f);
end;

procedure processFileGreaterThan70(var f: File_Worker);
var
    w: Worker;
begin
    writeln('Empleados mayores a 70 años:');
    reset(f);
    while (not eof(f)) do begin
        read(f,w);
        if (w.edad > AGE_COMP) then
            writeln('   ', w.num, ', ',w.nom, ', ',w.ape, ', ',w.dni, ', ',w.edad);
    end;
    close(f);
end;

var
    f: File_Worker;
begin
    createFile(f);
    processFileByNameOrSurname(f, 'pepe');
    processFileInLine(f);
    processFileGreaterThan70(f);
end.