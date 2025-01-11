package ar.edu.unlp.info.oo2.ejercicio_6;

public class EmpleadoPlanta extends EmpleadoConFamilia{
    private Integer antiguedad;

    EmpleadoPlanta(Integer antiguedad, Boolean estaCasado, Integer cantidadDeHijos) {
        super(50_000., estaCasado, cantidadDeHijos);
        this.antiguedad = antiguedad;
    }

    @Override
    public Double getAdicional() {
        return super.getAdicional() +  2_000 * this.antiguedad;
    }
}
