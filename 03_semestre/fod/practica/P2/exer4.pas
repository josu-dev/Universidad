program exer4;
const
    N_MAQUINAS = 5;
    RUTA_MAESTRO = './nav/log';

type
    detalle = record
        cod_usuario: integer;
        fecha: string;
        tiempo_sesion: integer;
    end;

    file_detalles = file of detalle;

    usuario = record
        cod_usuario: integer;
        fecha: string;
        tiempo_total_de_sesiones_abiertas: integer;
    end;

    file_usuarios = file of usuario;

    data = record
        d : detalle;
        f : file_detalles;
    end;

    a_data = array[1..N_DETALLES] of data;

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
    for i:= 1 to N_MAQUINAS do begin
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
    for i:= 1 to N_MAQUINAS do begin
        close(d[i].f)
    end;
end;

procedure minimo(var detalles:a_data; var min: detalle);
var
    i,pos: integer;
begin
    min.cod := 9999;
    pos:= -1;
    for i:=1 to N_MAQUINAS do begin
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

procedure generarMaestro();
var
    detalles: a_data;
    min: detalle;
    fMas: file_usuarios;
    u: usuario;
begin
    cargarDetalles(detalles);
    assign(fMas, RUTA_MAESTRO);
    rewrite(fMas);
    minimo(detalles, min);
    while (min.cod <> -1) do begin
        u.cod_usuario := min.cod_usuario;
        while (min.cod <> -1 and u.cod_usuario = min.cod_usuario) do begin
            u.fecha := min.fecha;
            u.tiempo_total_de_sesiones_abiertas := 0;
            while (min.cod <> -1 and u.cod_usuario = min.cod_usuario and u.fecha = min.fecha) do begin
                u.tiempo_total_de_sesiones_abiertas += min.tiempo_sesion;
                minimo(detalles, min);
            end;
            write(fMas, u);
        end;
    end;
    close(fMas);
    cerrarDetalles(detalles);
end;
