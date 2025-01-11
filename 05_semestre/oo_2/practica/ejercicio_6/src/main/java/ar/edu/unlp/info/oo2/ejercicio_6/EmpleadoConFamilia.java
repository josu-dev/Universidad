package ar.edu.unlp.info.oo2.ejercicio_6;

public class EmpleadoConFamilia extends Empleado {
    private Boolean estaCasado;
    private Integer cantidadDeHijos;

    EmpleadoConFamilia(Double basico, Boolean estaCasado, Integer cantidadDeHijos) {
        super(basico);
        this.cantidadDeHijos = cantidadDeHijos;
    }

    public Boolean getEstaCasado() {
        return this.estaCasado;
    }

    public Double getAdicional() {
        return (this.estaCasado ? 5_000. : 0) + 2_000 * this.cantidadDeHijos;
    }
}
