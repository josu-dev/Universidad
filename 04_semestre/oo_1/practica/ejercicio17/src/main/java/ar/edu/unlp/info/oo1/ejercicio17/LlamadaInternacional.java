package ar.edu.unlp.info.oo1.ejercicio17;

import java.time.LocalDate;
import java.util.Date;

public class LlamadaInternacional extends Llamada {
	private String paisOrigen, paisDestino;
	
	public LlamadaInternacional(LocalDate fecha, Date comienzo, double duracion, String emisor, String receptor, String paisOrigen, String paisDestino) {
		super(fecha,comienzo, duracion, emisor, receptor);
		this.paisOrigen = paisOrigen;
		this.paisDestino = paisDestino;
	}
	
	public double calcularCosto(CuadroTarifario cuadroTarifario) {
		return cuadroTarifario.costoPorMinuto(this) * this.getDuracion();
	}
	
	public String getPaisOrigen() {
		return this.paisOrigen;
	}
}
