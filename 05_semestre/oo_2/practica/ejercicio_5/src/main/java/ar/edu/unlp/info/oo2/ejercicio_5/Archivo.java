package ar.edu.unlp.info.oo2.ejercicio_5;

import java.time.LocalDate;

public class Archivo extends Entrada {
    Archivo(String nombre, LocalDate fechaCreacion, int tamano) {
        super(nombre, fechaCreacion, tamano);
    }

    public int tamanoTotalOcupado() {
        return this.getTamano();
    }
}
