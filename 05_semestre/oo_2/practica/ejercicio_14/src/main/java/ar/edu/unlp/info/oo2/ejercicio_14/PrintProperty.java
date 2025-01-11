package ar.edu.unlp.info.oo2.ejercicio_14;

import java.util.Date;

public abstract class PrintProperty implements FileOO2 {
    private FileOO2 component;

    public PrintProperty(FileOO2 file) {
        this.component = file;
    }

    public String getNombre() {
        return this.component.getNombre();
    }

    public String getExtension() {
        return this.component.getExtension();
    }

    public int getTamaño() {
        return this.component.getTamaño();
    }

    public Date getFechaCreacion() {
        return this.component.getFechaCreacion();
    }

    public Date getFechaModificacion() {
        return this.component.getFechaModificacion();
    }

    public String getPermisos() {
        return this.component.getPermisos();
    }

    public String prettyPrint() {
        return this.component.prettyPrint();
    }
}
