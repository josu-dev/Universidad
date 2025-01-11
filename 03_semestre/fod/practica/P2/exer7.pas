program exer7;
const
    CORTE = 9999;
    NOM_DETALLE = 'ventas';
type
    producto = record
        cod: integer;
        nom: string;
        pre: real;
        s_act: integer;
        s_min: integer;
    end;
    file_maestro = file of producto;

    venta = record
        cod: integer;
        cant: integer;
    end;
    file_detalle = file of venta;

procedure leerDetalle(var f: file_detalle; var d: venta);
begin
    if (eof(f)) then
        d.cod := CORTE
    else
        read(f, d);
end;

procedure actualizarMaestro(var fMas: file_maestro);
var
    v : venta;
    p : producto;
    fDet : file_detalle;
    codActual : integer;
begin
    assign(fDet, NOM_DETALLE);
    reset(fDet);
    reset(fMas);
    leerDetalle(fDet, v);
    read(fMas, p);
    while (v.cod <> CORTE) do begin
        while (p.cod<>v.cod) do
            read(fMas, p)
        codActual:= p.cod;
        while(v.cod = codActual) do begin
            p.cant_act -= v.cant;
            leerDetalle(fDet, v);
        end;
        seek(fMas, filePos(fMas) -1);
        write(fMas, p);
    end;
end;
procedure exportarMinimos(var f: file_maestro);
var
    p: producto;
    fTxt : text;
begin
    assign(fTxt, 'stock_minimo.txt');
    rewrite(fTxt);
    reset(f);
    while (not eof(f)) do begin
        read(f, p);
        if (p.s_act < p.s_min) then begin
            writeln(fTxt, p.cod, ' ', p.nom);
            writeln(fTxt, p.s_act, ' ', p.s_min, ' ', p.pre);
        end;
    end;
    close(f);
    close(fTxt);
end;

var
    fMas : file_maestro;
    opc: char;
begin
    repeat
        writeln('0 - Para salir');
        writeln('1 - Para actualizar stocks');
        writeln('2 - Para exportar minimos');
        write('Opcion: '); readln(opc);

        case opc of
            '0': writeln('Cerrando');
            '1': actualizarMaestro(fMas);
            '2': exportarMinimos(fMas);
            else writeln('Ingrese una opcion valida');
        end;
    until (opc='0');
end.