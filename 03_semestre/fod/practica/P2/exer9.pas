program exer9;

type
    mesa = record
        cod_prov: integer;
        cod_loc: integer;
        num_mesa: integer;
        votos: integer;
    end;
    fileMaestro = file of mesa;

procedure leerMesa(var f: fileMaestro; var m: mesa);
begin
    if (eof(f)) then
        m.cod_prov := -1
    else
        read(f, m);
end;
procedure informarResultados(var f: fileMaestro);
var
    m : mesa;
    actLoc, actProv: integer; 
    votosLoc, votosProv, votosTotal : integer;
begin
    reset(f);
    leerMesa(f, m);
    votosTotal:= 0;
    while (m.cod_prov <> -1) do begin
        actProv := m.cod_prov;
        votosProv:= 0;
        writeln('Provincia: ', actProv);
        while (actProv=m.cod_prov) do begin
            actLoc:= m.cod_loc;
            votosLoc:= 0;
            while (actProv = m.cod_prov) and (actLoc = m.cod_loc) do begin
                votosLoc += m.votos;
                leerMesa(f, m);
            end;
            writeln('Localidad: ', actLoc, ' Votos: ', votosLoc);
            votosProv += votosLoc;
        end;
        writeln('Votos: ', votosProv);
        votosTotal += votosProv;
    end;
    writeln('Total General de Votos: ', votosTotal);
    close(f);
end;