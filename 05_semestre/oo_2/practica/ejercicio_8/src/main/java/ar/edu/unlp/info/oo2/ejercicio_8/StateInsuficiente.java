package ar.edu.unlp.info.oo2.ejercicio_8;

public class StateInsuficiente extends State {
    StateInsuficiente(Excursion excursion) {
        super(excursion);
    }

    public State inscribir(Usuario unUsuario) {
        this.inscriptos.add(unUsuario);
        if (this.inscriptos.size() < this.excursion.getCupoMinimo()) {
            return this;
        }
        return new StateSuficiente(this.excursion, this.inscriptos);
    }

    public String obtenerInformacion() {
        return " usario faltantes para cupo minimo: " + (this.excursion.getCupoMinimo() - this.inscriptos.size());
    }
}
