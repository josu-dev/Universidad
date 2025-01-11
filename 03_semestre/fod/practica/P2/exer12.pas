program exer12;

type
    acceso = record
        anio: integer;
        mes: integer;
        dia: integer;
        idUsuario: integer;
        tiempo: integer;
    end;
    file_maestro = file of acceso;

procedure leerAcceso(var f: file_maestro; var a: acceso);
begin
    if (eof(f)) then
        a.anio:= -1
    else
        read(f, a);
end;
procedure generarInforme(var f: file_maestro);
var
    a: acceso;
    anioInforme, actMes, actDia, actId: integer;
    tiempoAnio, tiempoMes, tiempoDia, tiempoId: integer;
begin
    write('Ingrese el anio a generar el informe: '); readln(anioInforme);
    reset(f);
    leerAcceso(f, a);
    while (a.anio <> -1) and (a.anio <> anioInforme) do
        leerAcceso(f, a);
    if (a.anio <> anioInforme) then
        writeln('Anio no encontrado')
    else begin
        tiempoAnio:= 0;
        writeln('Anio: ', anioInforme);
        while (a.anio = anioInforme) do begin
            actMes:= a.mes;
            tiempoMes:= 0;
            writeln('Mes: ', actMes);
            while (a.anio = anioInforme) and (a.mes = actMes) do begin
                actDia:= a.dia;
                tiempoDia:= 0;
                writeln('Dia: ', actDia);
                while (a.anio = anioInforme) and (a.mes = actMes) and (a.dia = actDia) do begin
                    actId:= a.idUsuario;
                    tiempoId:= 0;
                    while (a.anio = anioInforme) and (a.mes = actMes) and (a.dia = actDia) and (a.idUsuario = actId) do begin
                        tiempoId+= a.tiempo;
                        leerAcceso(f,a);
                    end;
                    tiempoDia+= tiempoId;
                    writeln(actId, ' ', tiempoId);
                end;
                tiempoMes+= tiempoDia;
                writeln('Total tiempo de acceso dia ', actDia, ': ', tiempoDia);
            end;
            tiempoAnio+= tiempoMes;
            writeln('Total tiempo de acceso mes ', actMes, ': ', tiempoMes);
        end;
        writeln('Total tiempo de acceso anio: ', tiempoAnio);
    end;
    close(f);

end;