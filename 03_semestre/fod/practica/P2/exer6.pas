program exer6;

const
    CANT_DETALLES = 10;

type
    caso = record
        cod_loca : integer;
        cod_cepa : integer;
        cant_act : integer;
        cant_nue : integer;
        cant_rec : integer;
        cant_fal : integer;
    end;

    file_casos = file of caso;
    data = record
        d : caso;
        f : file_casos;
    end;
    a_data = array[1..CANT_DETALLES] of data;

    resumen = record
        cod_loc : integer;
        nom_loc : string;
        cod_cepa : string;
        nom_cepa : string;
        cant_act : integer;
        cant_nue : integer;
        cant_rec : integer;
        cant_fal : integer;
    end;

    file_maestro = file of resumen;


procedure leerCaso(var f: file_casos; var c: caso);
begin
    if (eof(f))
        c.cod_loc := 9999
    else
        read(f, c);
end;
procedure cargarDetalles(var a: a_data);
var
    i: integer;
    nom: string;
begin
    for i:= 1 to CANT_DETALLES do begin
        nom:= 'casos-' + i;
        assign(a[i].f, nom);
        reset(a[i].f)
        leerCaso(a[i].f, d[i].d)
    end;
end;
procedure cerrarDetalles(var a: a_data);
var
    i: integer;
begin
    for i:= 1 to CANT_DETALLES do
        close(a[i].f)
end;

procedure minimoCasos(var detalles:a_data; var min: caso);
var
    i,pos: integer;
begin
    min.cod_loc := 9999;
    pos:= -1;
    for i:=1 to N_ARCHIVOS do begin
        if (detalles[i].d.cod_loc<>9999 and detalles[i].d.cod_loc<min.cod_loc) begin
            pos:= i;
            min.cod := detalles[i].d.cod;
        end;
    end;
    if (pos<>-1) begin
        min := detalles[pos].d;
        leerCaso(detalles[pos].f, detalles[pos].d)
    end
end;
procedure actualizarMaestro(var fMas: file_maestro);
var
    res : resumen;
    detalles: a_data;
    min: caso;
    cantActivos, cantMas50Activos : integer;
    locActual : integer;
begin
    cantMas50Activos:= 0;
    cargarDetalles(detalles);
    reset(fMas);
    read(fMas, res);
    minimoCasos(detalles, min);
    while (min.cod_loc <> 9999) do begin
        while (res.cod_loc <> min.cod_loc) do begin
            locActual:= res.cod_loc;
            cantActivos:= 0;
            while (locActual = res.cod_loc) do begin
                cantActivos:= res.cant_act
                read(fMas, res);
            end;
            if (cantActivos>50) then
                cantMas50Activos+= 1;
        end;
        cantActivos:= 0;
        while(res.cod_loc = min.cod_loc) do begin
            while (res.cod_cepa <> min.cod_cepa) do begin
                cantActivos+= res.cant_act;
                read(fMas, res);
            end;
            cantActivos += min.cant_act;
            res.cant_fal+= min.cant_fal;
            res.cant_rec+= min.cant_rec;
            res.cant_act= min.cant_act;
            res.cant_nue= min.cant_act;
            seek(fMas, filePos(fMas) -1);
            write(fMas,res);
            minimoCasos(detalles, min);
        end;
        if (cantActivos>50) then
            cantMas50Activos+= 1;
    end;
    close(fMas);
    cerrarDetalles(detalles);
    writeln('La cantidad de localidades con mas de 50 casos activos es: ', cantMas50Activos)
end;