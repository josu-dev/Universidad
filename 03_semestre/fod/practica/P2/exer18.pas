program exer18;

const
    CORTE = -1;

type
    caso = record
        cod_localidad: integer;
        nombre_localidad: string;
        cod_municipio: integer;
        nombre_municipio: string;
        cod_hospital: integer;
        nombre_hospital: string;
        fecha: string;
        cantidad: integer;
    end;

    archivo_casos = file of caso;

procedure leerCaso(var arch: archivo_casos; var reg: caso);
begin
    if (eof(arch)) then
        reg.cod_localidad := CORTE
    else
        read(arch, reg);
end;

procedure exportar(var arch: text; nombre_localidad, nombre_municipio: string; cantidad: integer);
begin
    write(arch, cantidad, ' ', nombre_localidad);
    write(arch, nombre_municipio);
end;

procedure procesar(var arch: archivo_casos);
var
    actual, leido: caso;
    cantLocalidad, cantMunicipio: integer;
    arch_resumen: text;
begin
    assign(arch_resumen, './resumen.txt');
    rewrite(arch_resumen);
    reset(arch);
    leerCaso(arch, leido);
    while (leido.cod_localidad <> CORTE) do begin
        actual.cod_localidad := leido.cod_localidad;
        actual.nombre_localidad := leido.nombre_localidad;
        cantLocalidad := 0;
        writeln('Nombre: ', actual.nombre_localidad);
        while (leido.cod_localidad <> CORTE) and (leido.cod_localidad = actual.cod_localidad)  do begin
            actual.cod_municipio := leido.cod_municipio;
            actual.nombre_municipio := leido.nombre_municipio;
            cantMunicipio := 0;
            writeln('       Nombre: ', actual.nombre_municipio);
            while (leido.cod_localidad <> CORTE) and (leido.cod_localidad = actual.cod_localidad) and (leido.cod_municipio = actual.cod_municipio)  do begin
                actual.cod_hospital := leido.cod_hospital;
                actual.nombre_hospital := leido.nombre_hospital;
                actual.cantidad := 0;
                while (leido.cod_localidad <> CORTE) and (leido.cod_localidad = actual.cod_localidad) and (leido.cod_municipio = actual.cod_municipio) and (leido.cod_hospital = actual.cod_hospital)  do begin
                    actual.cantidad += leido.cantidad;
                    leerCaso(arch, leido);
                end;
                writeln('                 Nombre Hospital', actual.nombre_hospital, '    Cantidad de casos Hospital', actual.cantidad);
                cantMunicipio += actual.cantidad;
            end;
            writeln('       Cantidad de casos ', actual.nombre_municipio, ': ', cantMunicipio);
            if (cantMunicipio > 1500) then
                exportar(arch_resumen, actual.nombre_localidad, actual.nombre_municipio, cantMunicipio);
            cantLocalidad += cantMunicipio;
        end;
        writeln('Cantidad de casos ', actual.nombre_localidad, ': ', cantLocalidad);
    end;
    close(arch);
    close(arch_resumen)
end;

var
    arch: archivo_casos;
    nombre: string;
begin
    write('Ingrese nombre del archivo a cargar: '); readln(nombre);
    assign(arch, nombre);
    procesar(arch);
end.
