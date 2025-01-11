package ar.edu.unlp.info.oo2.ejercicio_14;

import java.util.Date;

public interface FileOO2 {
    public String getNombre();

    public String getExtension();

    public int getTamaño();

    public Date getFechaCreacion();

    public Date getFechaModificacion();

    public String getPermisos();

    public String prettyPrint();
}
