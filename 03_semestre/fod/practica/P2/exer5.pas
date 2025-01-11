program exer5;
const
    N_ARCHIVOS = 50;

type
    direccion = record
        calle: string;
        nro: integer;
        piso: integer;
        depto: string;
        ciudad: string;
    end;
    nacimiento = record
        partida: integer;
        nacimiento: string;
        nom: string;
        ape: string;
        dir: direccion;
        matricula: string;
        nom_madre: string;
        ape_madre: string;
        DNI_madre: integer;
        nom_padre: string;
        ape_padre: string;
        DNI_padre: string;
    end;
    file_nacimientos = file of nacimiento;

    fallecimiento = record
        partida: integer;
        nomYApe: string;
        DNI: integer;
        matricula: string;
        fecha: string;
        hora: string;
        lugar: string;
    end;
    file_fallecimientos = file of nacimiento;

    persona = record
        partida: integer;
        nacimiento: string;
        nomYApe: string;
        dir: direccion;
        medico_macimiento: string;
        nomYApe_madre: string;
        DNI_madre: integer;
        nomYApe_padre: string;
        DNI_padre: string;
        medico_fallecimiento: string;
        fecha: string;
        hora: string;
        lugar: string;
    end;
    file_personas = file of persona;

    data = record
        d_nac : nacimiento;
        f_nac : file_nacimientos;
        d_fal : fallecimiento;
        f_fal : file_fallecimientos;
    end;
    a_data = array[1..N_ARCHIVOS] of data;

procedure leerNacimiento(var f: file_nacimientos; var d: nacimiento);
begin
    if (eof(f))
        n.partida := 9999
    else
        read(f, d);
end;
procedure leerFallecimiento(var f: file_fallecimientos; var d: fallecimiento);
begin
    if (eof(f))
        d.partida := 9999
    else
        read(f, d);
end;
procedure cargarDetalles(var d: a_data);
var
    i: integer;
    nom: string;
begin
    for i:= 1 to N_ARCHIVOS do begin
        nom:= 'nacimiento-' + i;
        assign(d[i].f_nac, nom);
        reset(d[i].f_nac)
        leerNacimiento(d[i].f_nac, d[i].d_nac)
        nom:= 'fallecimiento-' + i;
        assign(d[i].f_fal, nom);
        reset(d[i].f_fal)
        leerFallecimiento(d[i].f_fal, d[i].d_fal)
    end;
end;
procedure cerrarDetalles(var d: a_data);
var
    i: integer;
begin
    for i:= 1 to N_ARCHIVOS do begin
        close(d[i].f_fal)
        close(d[i].f_nac)
    end;
end;

procedure minimoNacimiento(var detalles:a_data; var min: nacimiento);
var
    i,pos: integer;
begin
    min.cod := 9999;
    pos:= -1;
    for i:=1 to N_ARCHIVOS do begin
        if (detalles[i].d.cod<>-1 and detalles[i].d.cod<min.cod) begin
            pos:= i;
            min.cod := detalles[i].d.cod;
        end;
    end;
    if (pos<>-1) begin
        min := detalles[pos].d;
        leerDetalle(detalles[pos].f, detalles[pos].d)
    end
end;
procedure minimoFallecimiento(var detalles:a_data; var min: fallecimiento);
var
    i,pos: integer;
begin
    min.cod := 9999;
    pos:= -1;
    for i:=1 to N_ARCHIVOS do begin
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
procedure cargarNacimiento(var n: nacimiento; var p: persona);
begin
    p.partida := n.partida;
    p.nacimiento := n.nacimiento;
    p.nomYApe := n.nom + ' ' + n.ape;
    p.dir := n.dir;
    p.medico_nacimiento := n.matricula;
    p.nomYApe_madre := n.nom_madre + ' ' + n.ape_madre;
    p.DNI_madre := n.DNI_madre;
    p.nomYApe_padre := n.nom_padre + ' ' + n.ape_padre;
    p.DNI_padre := n.DNI_padre;
end;
procedure generarMaestro();
var
    detalles: a_data;
    minNac: nacimiento;
    minFal: fallecimiento;
    fMas: file_personas;
    fTxt: text;
    p: persona;
begin
    cargarDetalles(detalles);
    assign(fMas, 'actas_completas');
    rewrite(fMas);
    assign(fTxt, 'actas_completas.txt');
    rewrite(fTxt);
    minimoNacimiento(detalles, minNac);
    minimoFallecimiento(detalles, minFal);
    while (minNac.partida <> 9999) do begin
        cargarNacimiento(minNac, p);
        if (minNac.partida <> minFal.partida) then begin
            p.medico_fallecimiento := '';
            p.fecha := '';
            p.hora := '';
            p.lugar := '';
        end
        else begin
            p.medico_fallecimiento := minFal.matricula;
            p.fecha := minFal.fecha;
            p.hora := minFal.hora;
            p.lugar := minFal.lugar;
            minimoFallecimiento(detalles, minFal);
        end;
        write(fMas, p);
        leerNacimiento(detalles, minNac);
    end;
    close(fMas);
    cerrarDetalles(detalles);
end;
