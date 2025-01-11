program exer5extra;
const
    CANT_DELEGACIONES = 50;
type
    direccion = record
        calle: string;
        nro: integer;
        piso: integer;
        ciudad: string;
    end;

    nacimiento = record
        nro_nacimiento: integer;
        nombre_apellido: string;
        direccion : direccion;
        matricula_medico: string;
        nombre_apellido_madre : string;
        dni_madre: string;
        nombre_apellido_padre: string;
        dni_padre: string;
    end;
    fallecimiento = record
        nro_nacimiento: integer;
        dni: string;
        nombre_apellido: string;
        matricula_medico_fallecimiento: string;
        fecha_hora: string;
        lugar: string;
    end;
    arch_nacimientos = file of nacimiento;
    arch_fallecimientos = file of fallecimiento;

    delegacion = record
        nac: arch_nacimientos;
        fall: arch_fallecimientos;
    end;

    datos = record
        nac: nacimiento;
        fall: fallecimiento;
    end;

    arreglo_delegaciones = array [1..CANT_DELEGACIONES] of delegacion;
    arreglo_datos = array [1..CANT_DELEGACIONES] of datos;

    maestro = record
        nro_nacimiento: integer;
        nombre_apellido: string;
        direccion : direccion;
        matricula_medico: string;
        nombre_apellido_madre : string;
        dni_madre: string;
        nombre_apellido_padre: string;
        dni_padre: string;
        matricula_medico_fallecimiento: string;
        fecha_hora: string;
        lugar: string;
    end;

    arch_maestro = file of maestro;

procedure leerNacimiento(var arch: arch_nacimientos; var reg: nacimiento);
begin
    if (eof(arch)) then
        reg.nro_nacimiento := 9999
    else
        read(arch, reg);
end;
procedure leerFallecimiento(var arch: arch_fallecimientos; var reg: fallecimiento);
begin
    if (eof(arch)) then
        reg.nro_nacimiento := 9999
    else
        read(arch, reg);
end;

procedure minimo(var arreglo_del: arreglo_delegaciones; var arreglo_dat: arreglo_datos; var minNac: nacimiento; var minFall: fallecimiento);
var
    i: integer;
    posNac, posFall: integer;
begin
    minNac.nro_nacimiento := 9999;
    minFall.nro_nacimiento := 9999;
    for i:= 1 to CANT_DELEGACIONES do begin
        if arreglo_dat[i].nac.nro_nacimiento < minNac.nro_nacimiento then begin
            minNac := arreglo_dat[i].nac;
            posNac := i;
        end;
        if arreglo_dat[i].fall.nro_nacimiento < minFall.nro_nacimiento then begin
            minFall := arreglo_dat[i].fall;
            posFall := i;
        end;
    end;
    
    if (minNac.nro_nacimiento <> 9999) then begin
        leerNacimiento(arreglo_del[posNac].nac, arreglo_dat[posNac].nac);
        if (minNac.nro_nacimiento = minFall.nro_nacimiento) then
            leerFallecimiento(arreglo_del[posFall].fall, arreglo_dat[posFall].fall);
    end;
end;

procedure exportar(var arch:text; reg: maestro);
begin
    write(arch, reg.nro_nacimiento, ' ', reg.nombre_apellido);
    write(arch, reg.direccion.nro, ' ', reg.direccion.calle);
    write(arch, reg.direccion.piso, ' ', reg.direccion.ciudad);
    write(arch, reg.matricula_medico);
    write(arch, reg.nombre_apellido_madre);
    write(arch, reg.dni_madre);
    write(arch, reg.nombre_apellido_padre);
    write(arch, reg.dni_padre);
    write(arch, reg.matricula_medico_fallecimiento);
    write(arch, reg.fecha_hora);
    write(arch, reg.lugar);
end;

procedure iniciarDatos(var arreglo_del: arreglo_delegaciones; var arreglo_dat: arreglo_datos);
var
    i: integer;
begin
    for i:= 1 to CANT_DELEGACIONES do begin
        reset(arreglo_del[i].nac);
        leerNacimiento(arreglo_del[i].nac, arreglo_dat[i].nac);
        reset(arreglo_del[i].fall);
        leerFallecimiento(arreglo_del[i].fall, arreglo_dat[i].fall);
    end;
end;

procedure cerrarDel(var arreglo_del: arreglo_delegaciones);
var
    i: integer;
begin
    for i:= 1 to CANT_DELEGACIONES do begin
        close(arreglo_del[i].nac);
        close(arreglo_del[i].fall);
    end;
end;

procedure merge(var arreglo_del: arreglo_delegaciones; var a_maestro: arch_maestro);
var
    arreglo_dat: arreglo_datos;
    arch_text: text;
    minNac: nacimiento;
    minFall: fallecimiento;
    reg_maestro: maestro;
begin
    iniciarDatos(arreglo_del, arreglo_dat);
    assign(arch_text, './personas_resumen.txt');
    rewrite(arch_text);
    rewrite(a_maestro);
    minimo(arreglo_del, arreglo_dat, minNac, minFall);
    while(minNac.nro_nacimiento <> 9999) do begin
        
        reg_maestro.nro_nacimiento:= minNac.nro_nacimiento;
        reg_maestro.nombre_apellido:= minNac.nombre_apellido;
        reg_maestro.direccion := minNac.direccion;
        reg_maestro.matricula_medico:= minNac.matricula_medico;
        reg_maestro.nombre_apellido_madre := minNac.nombre_apellido_madre;
        reg_maestro.dni_madre:= minNac.dni_madre;
        reg_maestro.nombre_apellido_padre:= minNac.nombre_apellido_padre;
        reg_maestro.dni_padre:= minNac.dni_padre;

        if (minNac.nro_nacimiento = minFall.nro_nacimiento) then begin
            reg_maestro.matricula_medico_fallecimiento:= minFall.matricula_medico_fallecimiento;
            reg_maestro.fecha_hora:= minFall.fecha_hora;
            reg_maestro.lugar:= minFall.lugar;
        end
        else begin
            reg_maestro.matricula_medico_fallecimiento:= '';
            reg_maestro.fecha_hora:= '';
            reg_maestro.lugar:= '';
        end;

        exportar(arch_text, reg_maestro);
        write(a_maestro, reg_maestro);
        minimo(arreglo_del, arreglo_dat, minNac, minFall);
    end;
    cerrarDel(arreglo_del);
    close(arch_text);
    close(a_maestro);
end;

var
    arreglo_del: arreglo_delegaciones;
    a_maestro: arch_maestro;
begin
    // cargar arreglo de delegaciones
    // asignar nombre al maestro
    merge(arreglo_del, a_maestro);
end.
