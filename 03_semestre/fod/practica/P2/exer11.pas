program exer12;

type
    maestro = record
        nom_prov: string;
        n_alf: integer;
        n_enc: integer;
    end;
    file_maestro = file of maestro;

    detalle = record
        nom_prov: string;
        cod_loc: integer;
        n_alf: integer;
        n_enc: integer;
    end;
    file_detalle = file of detalle;

procedure leerDetalle(var f: file_detalle; var d: detalle);
begin
    if (eof(f)) then
        d.nom_prov := ' '
    else
        read(f, d);
end;
procedure minimo(var fDet1,fDet2: file_detalle; var det1, det2, min: detalle);
begin
    if (det1.nom_prov <> ' ') and (det1.nom_prov < det2.nom_prov) then begin
        min:= det1;
        leerDetalle(fDet1, det1);
    end
    else if (det2.nom_prov <> ' ') begin
        min:= det2;
        leerDetalle(fDet2, det2);
    end
    else
        min.nom_prov := ' ';
end;

procedure actualizarResumen(var f: file_maestro);
var
    fDet1, fDet2: file_detalle;
    det1, det2, min: detalle;
    res: maestro;
    act_nom: string;
    n_alf, n_enc: integer;
begin
    reset(f);
    assign(fDet1, 'censo-1');
    reset(fDet1);
    assign(fDet2, 'censo-2');
    reset(fDet2);
    read(f, res);
    leerDetalle(fDet1, det1);
    leerDetalle(fDet2, det2);
    minimo(fDet1, fDet2, det1, det2, min);
    while (min.nom_prov <> ' ') do begin
        act_nom:= min.nom_prov;
        n_alf:= 0;
        n_enc:= 0;
        while (act_nom = min.nom_prov) do begin
            n_alf += min.n_alf;
            n_enc += min.n_enc;
            minimo(fDet1, fDet2, det1, det2, min);
        end;
        if (n_enc <> 0) do begin
            while (res.nom_prov <> act_nom) do
                read(f, res);
            res.n_alf:= n_alf;
            res.n_enc:= n_enc;
            seek(f, filePos(f) -1);
            write(f, res);
        end;
    end;
    close(f);
    close(fDet1);
    close(fDet2);
end;