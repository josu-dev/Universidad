package ar.edu.unlp.info.oo1.ejercicio18;

import java.time.LocalDate;

public class ContratoTemporal implements Contrato {
	private Empleado empleado;
	private LocalDate inicioContrato;
	private LocalDate finContrato;
	private double valorHora;
	private double horasPorMes;
	
	public ContratoTemporal (Empleado empleado, LocalDate inicioContrato, LocalDate finContrato, double valorHora, double horasPorMes) {
		this.empleado = empleado;
		this.inicioContrato= inicioContrato;
		this.finContrato= finContrato;
		this.valorHora= valorHora;
		this.horasPorMes= horasPorMes;
	}
	
	public double calcularMonto() {
		return this.valorHora * this.horasPorMes;
	}
	
	public boolean esVencido() {
		return this.finContrato.isBefore(LocalDate.now());
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
