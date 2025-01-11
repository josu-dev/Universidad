package ar.edu.unlp.info.oo2.ejercicio_6;


public abstract class Empleado {
    private Double basico;
    private Double descuentoBasico;
    private Double descuentoAdicional;

    Empleado(Double basico) {
        this.basico = basico;
        this.descuentoBasico = 13.;
        this.descuentoAdicional = 5.;
    }

    public Double getBasico() {
        return this.basico;
    }

    abstract public Double getAdicional();

    public Double getDescuento() {
        return this.getBasico() * this.descuentoBasico + this.getAdicional() * this.descuentoAdicional;
    }

    public Double sueldo() {
        return this.getBasico() + this.getAdicional() - this.getDescuento();
    }
}
