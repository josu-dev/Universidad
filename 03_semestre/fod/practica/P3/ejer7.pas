program ejer7;

type
    especie = record
        cod: string;
        nom: string;
        fam: string;
        desc: string;
        zona: string;
    end;
    file_extincion = file of especie;

procedure borrarLogicamente(var f: file_extincion);
var
    cod: string;
    e: especie;
begin
    write('Ingrese cod: '); readln(cod);
    reset(f);
    while cod <> '500000' do begin
        seek(f, 0);
        read(f, e);
        while e.cod <> cod do
            read(f,e);
        e.cod := '!';
        seek(f, filePos(f) -1);
        write(f, e);
        write('Ingrese cod: '); readln(cod);
    end;
    close(f);
end;
procedure borradoFisico(var f: file_extincion);
var
    ultimoIndice,borrarIndice: integer;
    e: especie;
begin
    reset(f);
    ultimoIndice:= fileSize(f) -1;
    while (not eof(f)) do begin
        read(f, e);
        if e.cod = '!' then begin
            borrarIndice := filePos(f) -1;
            seek(f,ultimoIndice);
            read(f,e);
            while(e.cod = '!') do begin
                ultimoIndice:= ultimoIndice -1;
                seek(f,ultimoIndice);
                read(f,e);
            end;
            ultimoIndice:= ultimoIndice -1;
            seek(f,ultimoIndice);
            truncate(f);
            seek(f, borrarIndice);
            write(f, e);
        end;
    end;
    close(f);
end;