package ar.edu.unlp.info.oo1.ejercicio17;

import java.time.LocalDate;
import java.util.Date;

public class LlamadaLocal extends Llamada {
	public LlamadaLocal(LocalDate fecha, Date comienzo, double duracion, String emisor, String receptor) {
		super(fecha,comienzo, duracion, emisor, receptor);
	}
	
	public double calcularCosto(CuadroTarifario cuadroTarifario) {
		return cuadroTarifario.costoPorMinuto(this) * this.getDuracion();
	}
}
