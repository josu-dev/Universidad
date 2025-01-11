package ar.edu.unlp.info.oo2.ejercicio_14;

import java.util.Date;

public class File implements FileOO2 {
    private String nombre;
    private String extension;
    private int tamaño;
    private Date fechaCreacion;
    private Date fechaModificacion;
    private String permisos;

    public File(String nombre, String extension, int tamaño, Date fechaCreacion, Date fechaModificacion,
            String permisos) {
        this.nombre = nombre;
        this.extension = extension;
        this.tamaño = tamaño;
        this.fechaCreacion = fechaCreacion;
        this.fechaModificacion = fechaModificacion;
        this.permisos = permisos;
    }

    public String getNombre() {
        return this.nombre;
    }

    public String getExtension() {
        return this.extension;
    }

    public int getTamaño() {
        return this.tamaño;
    }

    public Date getFechaCreacion() {
        return this.fechaCreacion;
    }

    public Date getFechaModificacion() {
        return this.fechaModificacion;
    }

    public String getPermisos() {
        return this.permisos;
    }

    public String prettyPrint() {
        return "Datos del archivo:";
    }
}
