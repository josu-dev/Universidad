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


procedure showById(var f: File_Worker);
var
    w: Worker;
    id: string;
begin
    write('Ingrese el numero o apellido a buscar: ');
    readln(id);
    writeln('Empleados registrados como ', id, ':');
    reset(f);
    while (not eof(f)) do begin
        read(f,w);
        if ((w.ape = id) or (w.nom = id)) then
            writeln(w.num, ', ',w.nom, ', ',w.ape, ', ',w.dni, ', ',w.edad);
    end;
    close(f);
end;

procedure showAll(var f: File_Worker);
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

procedure showOlderThan(var f: File_Worker; age_comp: integer);
var
    w: Worker;
begin
    writeln('Empleados mayores a 70 años:');
    reset(f);
    while (not eof(f)) do begin
        read(f,w);
        if (w.edad > age_comp) then
            writeln('   ', w.num, ', ',w.nom, ', ',w.ape, ', ',w.dni, ', ',w.edad);
    end;
    close(f);
end;

function askToContinue(s: string): boolean;
var
    r: string;
begin
    writeln(s);
    writeln('Ingrese Si | No');
    readln(r);
    askToContinue := (r = 's') or (r = 'S') or (r = 'si') or (r = 'sI') or (r= 'Si') or (r='SI');
end;

procedure addWorkers(var f: File_Worker);
var
    w: Worker;
    bContinue: boolean;
begin
    reset(f);
    repeat
        readWorker(w);
        seek(f, fileSize(f));
        write(f, w);
        bContinue := askToContinue('Quiere añadir otro trabajador?');
    until not bContinue;
    close(f);
end;

procedure searhWorkerByNum(var f: File_Worker; num: integer; var w: Worker);
var
    finded: boolean;
begin
    finded:= false;
    seek(f, 0);
    while (not eof(f) and not finded) do begin
        read(f, w);
        finded := w.num = num;
    end;
end;

procedure modifyWorkers(var f: File_Worker);
var
    w: Worker;
    bContinue: boolean;
    num, edad: integer;
begin
    reset(f);
    repeat
        write('Ingrese el numero de trabajador a modificar: '); readln(num);
        write('Ingrese la nueva edad: '); readln(edad);
        searhWorkerByNum(f,num,w);
        w.edad := edad;
        seek(f, filePos(f) - 1);
        write(f, w);
        bContinue := askToContinue('Quiere modificar la edad de otro trabajador?');
    until not bContinue;
    close(f);
end;
procedure writeWorker(var f: TextFile; w: worker);
begin
    writeln(f, '   ', w.num, ', ',w.nom, ', ',w.ape, ', ',w.dni, ', ',w.edad);
end;

procedure exportAllWorkers(var f: File_Worker);
var
    w: Worker;
    nF: TextFile;
begin
    assign(nF, 'todos_empleados.txt');
    rewrite(nF);
    reset(f);
    while (not eof(f)) do begin
        read(f,w);
        writeWorker(nF,w);
    end;
    close(f);
    close(nF);
end;

procedure exportNoDniWorkers(var f: File_Worker);
var
    w: Worker;
    nF: TextFile;
begin
    assign(nF, 'altaDNIEmpleado.txt');
    rewrite(nF);
    reset(f);
    while (not eof(f)) do begin
        read(f,w);
        if (w.dni = '00') then
            writeWorker(nF,w);
    end;
    close(f);
    close(nF);
end;

var
    f: File_Worker;
    opc: char;
    bApp: boolean;
begin
    bApp := true;
    createFile(f);
    while bApp do begin
        writeln('Ingrese la opcion a elegir:');
        writeln('   1- Mostrar empleados con cierto nombre o apellido');
        writeln('   2- Mostrar todos los empleados');
        writeln('   3- Mostrar empleados mayores a ', AGE_COMP, ' años');
        writeln('   4- Añadir uno o mas empleados');
        writeln('   5- Modificar la edad de uno o mas empleados');
        writeln('   6- Exportar a .txt todos los empleados');
        writeln('   7- Exportar a .txt empleados sin dni');
        writeln('   0- Finalizar programa');
        write('Opcion: '); readln(opc);

        case opc of
            '1' : showById(f);
            '2' : showAll(f);
            '3' : showOlderThan(f, AGE_COMP);
            '4' : addWorkers(f);
            '5' : modifyWorkers(f);
            '6' : exportAllWorkers(f);
            '7' : exportNoDniWorkers(f);
            '0' : bApp := false;
            else writeln('Opcion no valdia');
        end;

        if (bApp) then begin
            write('Presione enter para continuar '); readln();
        end;
    end;
end.