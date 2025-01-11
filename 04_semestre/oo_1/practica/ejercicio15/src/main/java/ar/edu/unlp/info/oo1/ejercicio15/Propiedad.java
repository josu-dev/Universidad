package ar.edu.unlp.info.oo1.ejercicio15;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Propiedad {
	private List<DateLapse> fechasReservadas;
	private String nombre;
	private String descripcion;
	private String direccion;
	private double precioPorNoche;
	private Usuario dueño;
	
	public Propiedad (String nombre, String descripcion, String direccion, double precioPorNoche, Usuario dueño) {
		this.nombre = nombre;
		this.descripcion = descripcion;
		this.direccion = direccion;
		this.precioPorNoche = precioPorNoche;
		this.dueño = dueño;
		this.fechasReservadas = new ArrayList<DateLapse>();
	}

	public boolean estaDisponible(LocalDate fechaInicio, LocalDate fechaFin) {
		return this.fechasReservadas.stream()
				.anyMatch(f -> f.overlaps(fechaInicio, fechaFin));
	}

	public double calcularPrecio(DateLapse periodo) {
		return (periodo.sizeInDays() + 1)*this.precioPorNoche;
	}

	public double calcularIngreso(LocalDate fechaInicio, LocalDate fechaFin) {
		return this.fechasReservadas.stream()
				.mapToDouble(f -> f.overlapDays(fechaInicio, fechaFin) * this.precioPorNoche)
				.sum();
	}

	public Usuario getDueño() {
		return this.dueño;
	}

	public void ocupar(DateLapse periodo) {
		this.fechasReservadas.add(periodo);
	}
	public void liberar(DateLapse periodo) {
		this.fechasReservadas.remove(periodo);
	}	
}
