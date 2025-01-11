package ar.edu.unlp.info.oo1.ejercicio16;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Usuario {
	private String nombre, direccion;
	private Integer dni;
	private List<Propiedad> propiedades;
	
	public Usuario(String nombre, String direccion, Integer dni) {
		this.nombre = nombre; this.direccion = direccion;
		this.dni = dni;
		this.propiedades = new ArrayList<Propiedad>();
	}
	
	public List<Propiedad> getPropiedades() {
		return this.propiedades;
	}
	public void agregarPropiedad(Propiedad propiedad) {
		this.propiedades.add(propiedad);
	}

	public double calcularIngresos(LocalDate fechaInicio, LocalDate fechaFin) {
		return this.propiedades.stream()
				.mapToDouble(p -> p.calcularIngreso(fechaInicio, fechaFin))
				.sum();
	}
}
