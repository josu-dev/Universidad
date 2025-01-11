program exer2;
type
    alumno = record
        cod: integer;
        ape: string;
        nom: string;
        cursadas: integer;
        finales: integer;
    end;

    materia = record
        cod: integer;
        cursada: boolean;
        final: boolean;
    end;

    file_alumnos = file of comision;
    file_materias = file of materia;

procedure leerMateria(var f: file_materias; var m: materia);
begin
    if (eof(f))
        m.cod := -1
    else
        read(f, c);
end;

procedure actualizarAlumnos(var fMas: file_alumnos);
var
    fDet: file_materias;
    m: materia;
    a: alumno;
begin
    assign(fDet, 'detalle_materias');
    reset(fDet);
    reset(fMas);
    leerMateria(fDet, m);
    while (m.cod <> -1) do begin
        read(fMas, a)
        while (m.cod <> -1) & (m.cod = a.cod) do begin
            if (m.final)
                a.finales += 1
            else if (m.cursada)
                a.cursadas += 1;
            leerMateria(fDet, m);
        end;
        seek(fMas, filePos(fMas) -1);
        write(fMas, a)
    end;
    close(fDet);
    close(fMas);
end;

procedure exportarNormales(var fMas: file_alumnos);
var
    fTxt: text;
    a: alumno;
begin
    assign(fTxt, 'alumnosNormales.txt');
    rewrite(fTxt);
    reset(fMas);
    while (not eof(fMas)) do begin
        read(fMas, a);
        if (a.cursadas > 4 and a.finales = 0) then begin
            writeln(fTxt, a.cod, ' ', a.ape);
            writeln(fTxt, a.nom);
            writeln(fTxt, a.cursadas, ' ', a.finales);
        end;
    end;
    close(fMas);
    close(fTxt);
end;