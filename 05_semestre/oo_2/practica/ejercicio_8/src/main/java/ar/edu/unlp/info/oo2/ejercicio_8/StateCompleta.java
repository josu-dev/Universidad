package ar.edu.unlp.info.oo2.ejercicio_8;

import java.util.ArrayList;
import java.util.List;

public class StateCompleta extends State {
    private List<Usuario> listaEspera;

    StateCompleta(Excursion excursion, List<Usuario> inscriptos) {
        super(excursion);
        this.inscriptos = inscriptos;
        this.listaEspera = new ArrayList<>();
    }

    public State inscribir(Usuario unUsuario) {
        this.listaEspera.add(unUsuario);
        return this;
    }

    public Boolean isInscripcionDefinitiva() {
        return true;
    }
}
