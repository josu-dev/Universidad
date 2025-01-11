program exer13;

const
    RUTA_LOGS = './var/log/logmail.dat';

type
    log = record
        nro_usuario: integer;
        nombreUsuario: string;
        nombre: string;
        apellido: string;
        cantidadMailEnviados: integer;
    end;
    file_maestro = file of log;

    mail = record
        nro_usuario: integer;
        cuentaDestino: integer;
        cuerpoMensaje: string;
    end;
    file_detalle = file of mail;

    { orden nro_usuario, 0,1,+ mails por dia, procesamiento es unico por vez }

procedure actualizarLogs(var f: file_maestro);
var
    fDet : file_detalle;
begin
    assing(fDet, 'mailsdiarios.dat');
    reset(fDet);
    reset(f);
    leerMail(fDet, m);
    read(f, l);
    while (m.nro_usuario <> -1) do begin
        act_nro := m.nro_usuario;
        act_mails := 0;
        while (m.nro_usuario = act_nro) do begin
            act_mails +=1;
            leerMail(fDet, m);
        end;
        while (l.nro_usuario <> act_nro) do
            read(f, l);
        seek(f, filePos(f) -1);
        m.cantidadMailEnviados += act_mails;
        write(f, m);
    end;
    close(f);
    close(fDet);
end;

procedure generarResumen(var f: file_maestro; var fDet: file_detalle);
var
    l: log;
    m: mail;
    fTxt : text;
    act_mails: integer;
begin
    rewrite(fTxt, 'resumenusuarios.txt');
    reset(f);
    reset(fDet);
    leerMail(fDet, m);
    read(f, l);
    while (m.nro_usuario <> -1) do begin
        while (m.nro_usuario <> l.nro_usuario) do begin
            writeln(l.nro_usuario, ' ', l.cantidadMailEnviados);
            read(f, l);
        end;
        act_mails := 0;
        while (m.nro_usuario = l.nro_usuario) do begin
            act_mails +=1;
            leerMail(fDet, m);
        end;
        writeln(l.nro_usuario, ' ', m.act_mails)
    end;
    close(f);
    close(fDet);
    close(fTxt);
end;