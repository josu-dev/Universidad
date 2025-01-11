package ar.edu.unlp.info.oo2.ejercicio_8;

import java.util.List;

public class StateSuficiente extends State {
    StateSuficiente(Excursion excursion, List<Usuario> inscriptos) {
        super(excursion);
        this.inscriptos = inscriptos;
    }

    public State inscribir(Usuario unUsuario) {
        this.inscriptos.add(unUsuario);
        if (this.inscriptos.size() < this.excursion.getCupoMaximo()) {
            return this;
        }
        return new StateCompleta(this.excursion, this.inscriptos);
    }

    public String obtenerInformacion() {
        String emailsIncriptos = "email inscriptos:";
        for (Usuario usuario : inscriptos) {
            emailsIncriptos += " " + usuario.getEmail();
        }
        return emailsIncriptos + ", usarios faltantes para cupo maximo: " + (this.excursion.getCupoMaximo() - this.inscriptos.size());
    }
}
