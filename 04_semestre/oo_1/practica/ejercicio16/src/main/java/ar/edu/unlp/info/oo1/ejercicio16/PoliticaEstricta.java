package ar.edu.unlp.info.oo1.ejercicio16;

import java.time.LocalDate;

public class PoliticaEstricta implements PoliticaCancelacion {

	@Override
	public double calcularReembolso(Propiedad propiedad, DateLapse periodo, LocalDate fecha) {
		return 0;
	}
}
