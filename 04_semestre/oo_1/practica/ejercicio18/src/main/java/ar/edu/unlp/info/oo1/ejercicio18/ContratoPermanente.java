package ar.edu.unlp.info.oo1.ejercicio18;

import java.time.LocalDate;

public class ContratoPermanente implements Contrato {
	private Empleado empleado;
	private LocalDate inicioContrato;
	private double sueldoMensual;
	private double montoPorConyuge;
	private double montoPorHijos;
	
	public ContratoPermanente (Empleado empleado, LocalDate inicioContrato, double sueldoMensual, double montoPorConyuge, double montoPorHijos) {
		this.empleado = empleado;
		this.inicioContrato= inicioContrato;
		this.sueldoMensual= sueldoMensual;
		this.montoPorConyuge= montoPorConyuge;
		this.montoPorHijos= montoPorHijos;
	}
	
	public double calcularMonto() {
		double monto = this.sueldoMensual;
		if (this.empleado.tieneConyugeACargo())
			monto+= this.montoPorConyuge;
		if (this.empleado.tieneHijosACargo())
			monto+= this.montoPorHijos;
		return monto;
	}
	
	public boolean esVencido() {
		return false;
	}
	
	public LocalDate getFechaInicio() {
		return this.inicioContrato;
	}


	@Override
	public int compareTo(Contrato contrato) {
		if (this.inicioContrato.isBefore(contrato.getFechaInicio())) return 1;
		if (this.inicioContrato.equals(contrato.getFechaInicio())) return 0;
		return -1;
	}
}

