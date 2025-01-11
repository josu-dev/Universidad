program ejer8;

type
    distribucion = record
        nombre: string;
        lanzamiento: integer;
        version: string;
        desarrolladores: integer;
        descripcion: string;
    end;
    arch_distribuciones = file of distribucion;

procedure leerDistribucion(var arch: arch_distribuciones; var reg: distribucion);
begin
    if (eof(arch)) then
        reg.nombre := ' '
    else
        read(arch, reg);
end;

procedure ExisteDistribucion(var arch: arch_distribuciones; nombre: string; var existe: boolean);
var
    leido: distribucion;
begin
    reset(arch);
    leerDistribucion(arch, leido);
    leerDistribucion(arch, leido);
    while (leido.nombre <> ' ') and (not (leido.nombre = nombre) and (leido.lanzamiento > 0)) do begin
        leerDistribucion(arch, leido);
    end;
    existe := (leido.nombre = nombre) and (leido.lanzamiento > 0);
    close(arch);
end;

procedure AltaDistribucion(var arch: arch_distribuciones);
var
    nuevo, leido: distribucion;
    existe: boolean;
begin
    writeln('Ingrese nueva distribucion: ');
    write('nombre: '); readln(nuevo.nombre);
    write('lanzamiento: '); readln(nuevo.lanzamiento);
    write('version: '); readln(nuevo.version);
    write('desarrolladores: '); readln(nuevo.desarrolladores);
    write('descripcion: '); readln(nuevo.descripcion);
    ExisteDistribucion(arch, nuevo.nombre, existe);
    if (existe) then
        writeln('ya existe la distribución')
    else begin
        reset(arch);
        leerDistribucion(arch, leido);
        if (leido.lanzamiento < 0) then begin
            seek(arch, leido.lanzamiento * -1);
            read(arch, leido);
            seek(arch, filepos(arch) -1);
            write(arch, nuevo);
            seek(arch, 0);
            write(arch, leido);
        end
        else begin
            seek(arch, filesize(arch));
            write(arch, nuevo);
        end;
        close(arch);
    end;
end;

procedure BajaDistribucion(var arch: arch_distribuciones; nombre: string);
var
    existe: boolean;
    pos: integer;
    leida, cabezera: distribucion;
begin
    ExisteDistribucion(arch, nombre, existe);
    if (not existe) then
        writeln('Distribucion no existente')
    else begin
        reset(arch);
        
        leerDistribucion(arch, cabezera);

        leerDistribucion(arch, leida);
        while (leida.nombre <> nombre) do
            leerDistribucion(arch, leida);
        
        leida.lanzamiento := cabezera.lanzamiento;
        pos := filepos(arch) -1;
        seek(arch, pos);
        write(arch, leida);

        cabezera.lanzamiento := pos * -1;
        seek(arch, 0);
        write(arch, cabezera);

        close(arch);
    end;
end;

