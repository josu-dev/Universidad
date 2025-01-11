program ejer6;

type
    prenda = record
        cod_prenda: integer;
        descripcion: string;
        colores:string;
        tipo_prenda:integer;
        stock:integer;
        precio_unitario:real;
    end;
    file_prendas = file of prenda;

    file_cambio = file of integer;

procedure leerCambio(var fDet:file_cambio; var cod:integer);
begin
    if (eof(fDet)) then
        cod:= -1
    else
        read(fDet, cod);
end;
procedure bajarFueraTemporada(var fMas: file_prendas; var fDet: file_cambio);
var
    cod: integer;
    p: prenda;
    fAux: file_prendas;
begin
    reset(fDet);
    reset(fMas);
    while (not eof(fDet)) begin
        read(fDet,cod);
        seek(fMas, 0);
        read(fMas, p);
        while(p.cod_prenda <> cod) do
            read(fMas, p);
        p.stock:= -1;
        seek(fMas, filePos(fMas) -1);
        write(fMas, p);
    end;
    close(fDet);

    assign(fAux,'aux');
    rewrite(fAux);
    seek(fMas, 0);
    while (not eof(fMas)) do begin
        read(fMas, p);
        if (p.stock > -1) then
            write(fAux, p);
    end;
    close(fAux);
    close(fMas);
    rename(fMas,'prendas_viejas');
    rename(fAux,'prendas');
end;