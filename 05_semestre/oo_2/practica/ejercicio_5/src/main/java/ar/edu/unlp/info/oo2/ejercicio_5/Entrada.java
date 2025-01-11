package ar.edu.unlp.info.oo2.ejercicio_5;

import java.time.LocalDate;

public abstract class Entrada {
    private String nombre;
    private LocalDate fechaCreacion;
    private int tamano;

    Entrada(String nombre, LocalDate fechaCreacion, int tamano) {
        this.nombre = nombre;
        this.fechaCreacion = fechaCreacion;
        this.tamano = tamano;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public LocalDate getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(LocalDate fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    public int getTamano() {
        return tamano;
    }

    public void setTamano(int tamano) {
        this.tamano = tamano;
    }

    abstract public int tamanoTotalOcupado();

}
