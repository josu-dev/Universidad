program exer_1;
const
    I_CORTE = 30000;
    pepe = file of integer;

procedure createFile(var f: IntegerFile);
var
    d: integer;
begin
    rewrite(f);
    readln(d);
    while (d<> I_CORTE) do begin
        write(f, d);
        readln(d);
    end;
    close(f);
end;

procedure printFile(var f: IntegerFile);
var
    d: integer;
begin
    reset(f);
    while (not eof(f)) do begin
        read(f, d);
        writeln(d);
    end;
    close(f);
end;

var
    f: IntegerFile;
begin
    assign(f, 'f_e1_integers');
    createFile(f);
    printFile(f);
end.