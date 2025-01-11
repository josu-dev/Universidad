package ar.edu.unlp.info.oo1.ejercicio17;

import java.time.LocalDate;
import java.util.Date;

public class LlamadaInterurbana extends Llamada {
	private double distancia;
	
	public LlamadaInterurbana(LocalDate fecha, Date comienzo, double duracion, String emisor, String receptor, double distancia) {
		super(fecha,comienzo, duracion, emisor, receptor);
		this.distancia = distancia;
	}
	
	public double calcularCosto(CuadroTarifario cuadroTarifario) {
		return cuadroTarifario.costoPorMinuto(this) * this.getDuracion() + 5;
	}
	
	public double getDistancia() {
		return this.distancia;
	}
}