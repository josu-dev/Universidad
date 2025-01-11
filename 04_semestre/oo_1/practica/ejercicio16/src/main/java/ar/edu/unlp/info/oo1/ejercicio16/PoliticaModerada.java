package ar.edu.unlp.info.oo1.ejercicio16;

import java.time.LocalDate;

public class PoliticaModerada implements PoliticaCancelacion {

	@Override
	public double calcularReembolso(Propiedad propiedad, DateLapse periodo, LocalDate fecha) {
		int anticipacion = new DateLapse(fecha, periodo.getFrom()).sizeInDays();
		if (anticipacion < 2) return 0;
		if (anticipacion < 7) return propiedad.getPrecioPorNoche() * (periodo.sizeInDays() +1) * 0.5;
		return propiedad.getPrecioPorNoche() * (periodo.sizeInDays() +1);
	}
}
