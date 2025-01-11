package ar.edu.unlp.info.oo1.ejercicio16;

import java.time.LocalDate;

public class PoliticaFlexible implements PoliticaCancelacion {

	@Override
	public double calcularReembolso(Propiedad propiedad, DateLapse periodo, LocalDate fecha) {
		if (!fecha.isBefore(periodo.getFrom())) {
			return 0;
		}
		return propiedad.getPrecioPorNoche() * (periodo.sizeInDays() +1);
	}

}
