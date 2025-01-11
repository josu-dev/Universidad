program exer3;
const
    N_DETALLES = 30;
type
    producto = record
        cod: integer;
        nom: string;
        desc: string;
        s_act: integer;
        s_min: integer;
        precio: real;
    end;

    detalle = 

    file_detalles = file of detalle;

    data = record
        d : detalle;
        f : file_detalles;
    end;

    a_data = array[1..N_DETALLES] of data;

    file_productos = file of producto;

procedure leerDetalle(var f: file_detalles; var d: detalle);
begin
    if (eof(f))
        d.cod := -1
    else
        read(f, d);
end;
procedure cargarDetalles(var d: a_data);
var
    i: integer;
    nom: string;
begin
    for i:= 1 to N_DETALLES do begin
        nom:= 'detalle-' + i;
        assign(d[i].f, nom);
        reset(d[i].f)
        leerDetalle(d[i].f, d[i].d)
    end;
end;
procedure cerrarDetalles(var d: a_data);
var
    i: integer;
begin
    for i:= 1 to N_DETALLES do begin
        close(d[i].f)
    end;
end;

procedure minimo(var detalles:a_detalles; var min: detalle);
var
    i,pos: integer;
begin
    min.cod := 9999;
    pos:= -1;
    for i:=1 to N_DETALLES do begin
        if (detalles[i].d.cod<>-1 and detalles[i].d.cod<min.cod) begin
            pos:= i;
            min.cod := detalles[i].d.cod;
        end;
    end;
    if (pos<>-1) begin
        min := detalles[pos].d;
        leerDetalle(detalles[pos].f, detalles[pos].d)
    end
    else
        min.cod := -1;
end;

procedure actualizarMaestro(var fMas: file_productos);
var
    detalles: a_data;
    min, dTotal: detalle;
    p: producto;
    fTxt: text;
begin
    cargarDetalles(detalles);
    assign(fTxt, 'stock_insuficiente.txt');
    rewrite(fTxt);
    reset(dMas);
    read(dMas, p);
    minimo(detalles, min);
    while (min.cod <> -1) do begin
        dTotal.cod := min.cod;
        dTotal.cant := 0;
        while (min.cod <> -1 and dTotal.cod = min.cod) do begin
            dTotal.cant += min.cant;
            minimo(detalles, min);
        end;
        while (dTotal.cod <> p.cod) do
            read(dMas, p)
        p.s_act -= dTotal.cant;
        if (p.s_act < p.s_min) then begin
            writeln(fTxt, p.nom,);
            writeln(fTxt, p.desc);
            writeln(fTxt, p.s_act, ' ', p.precio:0:2);
        end;
    end;
    close(fMas);
    close(fTxt);
    cerrarDetalles(detalles);
end;