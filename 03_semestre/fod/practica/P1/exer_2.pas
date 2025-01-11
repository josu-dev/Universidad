program exer_2;
const
    I_COMP = 1500;
type
    IntegerFile = file of integer;

procedure selectFile(var f: IntegerFile);
var
    sNom: String;
begin
    write('Ingrese el nombre del archivo a utilizar: ');
    readln(sNom);
    assign(f, sNom);
end;

procedure processFile(var f: IntegerFile; var nGT1500: integer; var prom: real);
var
    i,n,t: integer;
begin
    nGT1500 := 0;
    t := 0;
    n := 0;
    reset(f);
    while (not eof(f)) do begin
        n := n + 1;
        read(f, i);
        t := t + (i div n);
        if (i < I_COMP) then
            nGT1500 := nGT1500 + 1;
        writeln('numero: ', i);
    end;
    close(f);
    if (n = 0) then prom := 0
    else prom := t;
end;

var
    f: IntegerFile;
    nGT1500: integer;   
    prom: real;
begin
    selectFile(f);
    processFile(f,nGT1500,prom);
    writeln('Cantidad numeros menores a ', I_COMP, ': ', nGT1500);
    writeln('Promedio de los numeros: ', prom:2:2);
end.