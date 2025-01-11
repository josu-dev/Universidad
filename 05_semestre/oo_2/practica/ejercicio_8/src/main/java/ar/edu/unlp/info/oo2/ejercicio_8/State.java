package ar.edu.unlp.info.oo2.ejercicio_8;

import java.util.ArrayList;
import java.util.List;

abstract public class State {
    protected Excursion excursion;
    protected List<Usuario> inscriptos;

    State(Excursion excursion) {
        this.excursion = excursion;
        this.inscriptos = new ArrayList<>();
    }

    abstract public State inscribir(Usuario unUsuario);

    public String obtenerInformacion() {
        return "";
    }

    public Boolean isInscripcionDefinitiva() {
        return false;
    }
}
