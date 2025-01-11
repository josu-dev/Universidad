program exer14;
type
    vuelo = record
        destino: string;
        fecha: string;
        hora_salida: string;
        disponibles: integer;
    end;
    file_maestro = file of vuelo;

    compra = record
        destino: string;
        fecha: string;
        hora_salida: string;
        comprados: integer;
    end;
    file_detalle = file of compra;

procedure leerDetalle(var f: file_detalle; var c: compra);
begin
    if (eof(f)) then
        c.destino := ' '
    else
        read(f, c);
end;
procedure recorrerMaestro(var f: file_maestro);
var
    minimoDisponibles : integer;
    fDet1, fDet2: file_detalle;
    v: vuelo;
    c1, c2, min: compra;
    actDestino, actFecha, actHoraSalida: string;
    minimoDisponibles, comprados := integer;
begin
    write('Ingrese la cantidad minima de asientos para generar la lista: '); readln(minimoDisponibles);
    reset(f);
    leerDetalle(fDet1, c1);
    leerDetalle(fDet2, c2);
    read(f, v);
    minimo(fDet1, fDet2, c1, c2, min);
    while (min.destino <> ' ') do begin
        actDestino := min.destino;
        while (actDestino = min.destino) do begin
            actFecha := min.fecha;
            while (actDestino = min.destino) and (actFecha = min.fecha) do begin
                actHoraSalida := min.hora_salida;
                comprados:= 0;
                while (actDestino = min.destino) and (actFecha = min.fecha) and (actHoraSalida = min.hora_salida) do begin
                    comprados += min.comprados;
                    minimo(fDet1, fDet2, c1, c2, min);
                end;
                while (actDestino <> v.destino) and (actFecha <> v.fecha) and (actHoraSalida <> v.hora_salida) do begin
                    if (v.disponibles < minimoDisponibles) then
                        writeln('El vuelo con destino: ', v.destino, ', fecha: ', v.fecha, ', salida: ', v.hora_salida, ', tiene menos de la cantidad ingresada');
                    read(f, v);
                end;
                v.disponibles -= comprados;
                if (v.disponibles < minimoDisponibles) then
                    writeln('El vuelo con destino: ', v.destino, ', fecha: ', v.fecha, ', salida: ', v.hora_salida, ', tiene menos de la cantidad ingresada');
                seek(f, filePos(f) -1);
                write(f, v);
            end;
        end;
    end;
    close(fDet1);
    close(fDet2);
    while (not eof(f)) do begin
        read(f, v);
        if (v.disponibles < minimoDisponibles) then
            writeln('El vuelo con destino: ', v.destino, ', fecha: ', v.fecha, ', salida: ', v.hora_salida, ', tiene menos de la cantidad ingresada');
    end;
    close(f);
end;