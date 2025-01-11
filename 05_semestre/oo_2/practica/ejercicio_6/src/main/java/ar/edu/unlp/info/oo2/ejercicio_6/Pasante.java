package ar.edu.unlp.info.oo2.ejercicio_6;

public class Pasante extends Empleado {
    private Integer examenesRendidos;

    Pasante(Integer examenesRendidos) {
        super(20_000.);
        this.examenesRendidos = examenesRendidos;
    }

    public Double getAdicional() {
        return 2_000. * this.examenesRendidos;
    }
}
