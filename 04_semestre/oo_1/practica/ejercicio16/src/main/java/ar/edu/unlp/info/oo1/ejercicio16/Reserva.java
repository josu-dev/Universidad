package ar.edu.unlp.info.oo1.ejercicio16;

import java.time.LocalDate;

public class Reserva {
	private Propiedad propiedad;
	private DateLapse periodo;
	private Usuario inquilino;
	
	public Reserva(Propiedad propiedad, DateLapse periodo, Usuario inquilino) {
		this.propiedad = propiedad;
		this.periodo = periodo;
		this.inquilino = inquilino;
		this.propiedad.ocupar(periodo);
	}
	
	
	public void eliminar() {
		this.propiedad.liberar(periodo);
	}


	public double costoTotal() {
		return this.propiedad.calcularPrecio(periodo);
	}


	public boolean esEliminable() {
		return this.periodo.getFrom().isAfter(this.periodo.getTo());
	}


	public Usuario getInquilino() {
		return this.inquilino;
	}


	public Usuario getDueño() {
		return this.propiedad.getDueño();
	}


	public double costo(LocalDate fechaInicio, LocalDate fechaFin) {
		return this.propiedad.calcularIngreso(fechaInicio, fechaFin);
	}
	
	public double reembolso(LocalDate fecha) {
		return this.propiedad.calcularReembolso(this.periodo, fecha);
	}
}
