package ar.edu.unlp.info.oo1.ejercicio18;

import java.time.LocalDate;

public class Recibo {
	private String nombre;
	private String apellido;
	private String cuil;
	private LocalDate fechaEmision;
	private int antiguedad;
	private double monto;

	public Recibo (String nombre, String apellido, String cuil, int antiguedad ,LocalDate fechaEmision, double monto) {
		this.nombre = nombre;
		this.apellido = apellido;
		this.cuil = cuil;
		this.fechaEmision= fechaEmision;
		this.monto = monto;
		this.antiguedad = antiguedad;
	}

}
