package ar.edu.unlp.info.oo1.ejercicio9;

public class CuentaCorriente extends Cuenta {
	private double descubrimiento;
	
	public CuentaCorriente () {
		super();
		this.descubrimiento = 0;
	}
	
	public double getDescubrimiento() {
		return descubrimiento;
	}
	public void setDescubrimiento(double descubrimiento) {
		this.descubrimiento = descubrimiento;
	}
	@Override
	protected boolean puedeExtraer(double monto) {
		return (this.getSaldo() - monto) > this.descubrimiento;
	}

}
