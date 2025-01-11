package ar.edu.unlp.info.oo1.ejercicio16;

import java.time.LocalDate;

public interface PoliticaCancelacion {
	public double calcularReembolso(Propiedad propiedad, DateLapse periodo, LocalDate fecha);
}
