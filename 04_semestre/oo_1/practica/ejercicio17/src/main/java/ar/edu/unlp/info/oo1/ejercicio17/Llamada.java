package ar.edu.unlp.info.oo1.ejercicio17;

import java.time.LocalDate;
import java.util.Date;

public abstract class Llamada {
	private LocalDate fecha;
	private Date comienzo;
	private double duracion;
	private String emisor;
	private String receptor;
	
	public Llamada(LocalDate fecha, Date comienzo, double duracion, String emisor, String receptor) {
		this.fecha = fecha;
		this.comienzo = comienzo;
		this.duracion = duracion;
		this.emisor = emisor;
		this.receptor = receptor;
	}

	public String telefonoEmisor() {
		return emisor;
	}
	public String telefonoReceptor() {
		return receptor;
	}
	public double getDuracion() {
		return this.duracion;
	}
	public Date getComienzo() {
		return this.comienzo;
	}
	public LocalDate getFecha() {
		return this.fecha;
	}
	public abstract double calcularCosto(CuadroTarifario cuadroTarifario);
}
