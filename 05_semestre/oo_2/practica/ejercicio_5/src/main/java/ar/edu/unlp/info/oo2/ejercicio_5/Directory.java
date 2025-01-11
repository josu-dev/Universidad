package ar.edu.unlp.info.oo2.ejercicio_5;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Directory extends Entrada {
    private List<Entrada> entradas;

    Directory(String nombre, LocalDate fechaCreacion) {
        super(nombre, fechaCreacion, 32);
        this.entradas = new ArrayList<>();
    }

    public int tamanoTotalOcupado() {
        return this.getTamano() + this.entradas.stream()
                .mapToInt(entrada -> entrada.tamanoTotalOcupado())
                .sum();
    }

    public Archivo archivoMasGrande() {
        return (Archivo) this.entradas.stream()
                .reduce((acc, act) -> {
                    if (acc == null) {
                        if (act instanceof Archivo) {
                            return act;
                        }
                        return ((Directory) act).archivoMasGrande();
                    }
                    if (act instanceof Archivo) {
                        return acc.getTamano() >= act.getTamano() ? acc : act;
                    }
                    Archivo temp = ((Directory) act).archivoMasGrande();
                    return (temp != null && acc.getTamano() >= temp.getTamano()) ? acc : act;
                })
                .orElse(null);
    }
    
    public Archivo archivoMasNuevo() {
        return (Archivo) this.entradas.stream()
                .reduce((acc, act) -> {
                    if (acc == null) {
                        if (act instanceof Archivo) {
                            return act;
                        }
                        return ((Directory) act).archivoMasGrande();
                    }
                    if (act instanceof Archivo) {
                        return acc.getFechaCreacion().isAfter(act.getFechaCreacion()) ? acc : act;
                    }
                    Archivo temp = ((Directory) act).archivoMasNuevo();
                    return (temp != null && acc.getFechaCreacion().isAfter(temp.getFechaCreacion())) ? acc : act;
                })
                .orElse(null);
    }
}
