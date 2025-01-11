package ar.edu.unlp.info.oo1.ejercicio9;

public class CajaDeAhorro extends Cuenta {
	private final double COSTO_ADICIONAL = 1.02;
	
	@Override
	protected boolean puedeExtraer(double monto) {
		return this.getSaldo() >= monto*COSTO_ADICIONAL;
	}
/*
	@Override
	public void depositar(double monto) {
		this.super().saldo += monto;
	}

	@Override
	protected void extraerSinControlar(double monto) {
		this.saldo -= monto;
	}
	*/
}
