package ar.edu.unlp.info.oo1.ejercicio18;

import java.time.LocalDate;

public interface Contrato extends Comparable<Contrato> {
	public double calcularMonto();
	public boolean esVencido();
	public LocalDate getFechaInicio();
}
