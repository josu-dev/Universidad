program exer10;

const
    CANT_CATEGORIAS = 15;
    ARCHIVO_VALORES_HORAS_EXTRAS = 'ValoresHorasExtras.txt';

type
    empleado = record
        dep: string;
        div: string;
        num: integer;
        cat: integer;
        hotas: integer;
    end;
    
    fileMaestro = file of empleado;

    categorias = array[1..CANT_CATEGORIAS] of real;

procedure cargarCategorias(var c:categorias);
var
    i, n: integer;
    v: real;
    fTxt: text;
begin
    assign(fTxt, ARCHIVO_VALORES_HORAS_EXTRAS);
    reset(fTxt);
    for i := 1 to CANT_CATEGORIAS do begin
        readln(fTxt,n,v);
        c[n] := v
    end;
    close(fTxt);
end;

procedure leerEmpleado(var f: fileMaestro; var e: empleado);
begin
    if (eof(f)) then
        e.dep := ' '
    else
        read(f, e);
end;
procedure listarResumen(var f: fileMaestro; c: categorias);
var
    actDep, actDiv: string;
    actEmp: integer;
    horasDep, horasDiv, horasEmp: integer;
    montoDep, montoDiv, montoEmp: real;
begin
    reset(f);
    leerEmpleado(f, e);
    while (e.dep <> ' ') do begin
        actDep := e.dep;
        horasDep:= 0;
        montoDep:= 0;
        writeln('Departamento: ', actDep);
        while (actDep = e.dep) do begin
            actDiv := e.div;
            horasDiv:= 0;
            montoDiv:= 0;
            writeln('Division: ', actDiv);
            writeln('Numero de Empleado  Total de Hs.  Importe a cobrar');
            while (actDep = e.dep) and (actDiv = e.div) do begin
                actEmp := e.num;
                horasEmp:= 0;
                montoEmp:= 0;
                while (actDep = e.dep) and (actDiv = e.div) and (actEmp = e.num) do begin
                    horasEmp+= e.horas;
                    montoEmp+= e.horas * c[e.cat];
                    leerEmpleado(f, e);
                end;
                writeln(actEmp, '         ', horasEmp, '        ', montoEmp);
                horasDiv+= horasEmp;
                montoDiv+= montoEmp;
            end;
            writeln('Total horas division: ', horasDiv);
            writeln('Total monto division: ', montoDiv);
            horasDep+= horasDiv;
            montoDep+= montoDiv;
        end;
        writeln('Total horas departamento: ', horasDep);
        writeln('Total monto departamento: ', montoDep);
    end;
    close(f);
end;