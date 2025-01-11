program exer8;
const
    CORTE = 9999;
type
    cliente = record
        cod: integer;
        nombre: string;
        apellido: string;
    end;
    venta = record
        cli: cliente;
        anio: integer;
        mes: integer;
        dia: integer;
        monto: integer;
    end;

    file_maestro = file of venta;

procedure leerMaestro(var f: file_maestro; var v: venta);
begin
    if (eof(f)) then
        v.cli.cod := CORTE
    else
        read(f, v);
end;
procedure reportar(var f: file_maestro);
var
    v, act_v: venta;
    cod_act, act_anio, act_mes: integer;
    monto_anio, monto_mes: real;
begin
    reset(f);
    leerMaestro(f, v);
    while(v.cli.cod <> CORTE) do begin
        cod_act:= v.cli.cod;
        writeln('Cliente: ', v.cli.cod, ', ', v.cli.nom, ', ',v.cli.ape);
        while (cod_act = v.cli.cod) do begin
            act_anio := v.anio;
            monto_anio:= 0;
            while (cod_act = v.cli.cod) and (act_anio = v.anio) do begin
                act_mes:= v.mes;
                monto_mes:= 0;
                while (cod_act = v.cli.cod) and (act_anio = v.anio) and (act_mes = v.mes) do begin
                    monto_mes+= v.monto;
                    leerMaestro(f, v);
                end;
                if (monto_mes<> 0) then begin
                    writeln('Monto mes ', act_mes, ': ', monto_mes);
                    monto_anio+= monto_mes;
                end;
            end;
            writeln('Monto anio ', act_anio, ': ', monto_anio);
        end;
    end;
end;