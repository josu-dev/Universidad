package ar.edu.unlp.info.oo2.ejercicio_6;

public class Temporario extends EmpleadoConFamilia{
    private Double horasTrabajadas;

    Temporario(Boolean estaCasado, Integer cantidadDeHijos, Double horasTrabajadas) {
        super(20_000 + horasTrabajadas * 300, estaCasado, cantidadDeHijos);
        this.horasTrabajadas = horasTrabajadas;
    }

    public Double getBasico() {
        return 20_000. + this.horasTrabajadas * 300;
    }
}
