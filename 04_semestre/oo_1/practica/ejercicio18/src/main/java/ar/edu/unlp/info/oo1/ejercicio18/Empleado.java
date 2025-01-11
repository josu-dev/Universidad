package ar.edu.unlp.info.oo1.ejercicio18;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Empleado {

	private String nombre;
	private String apellido;
	private String cuil;
	private LocalDate fechaNacimiento;
	private boolean conyugeACargo;
	private boolean hijosACargo;
	private LocalDate fechaInicio;
	private List<Contrato> contratos;

	public Empleado (String nombre, String apellido, String cuil, LocalDate fechaNacimiento, boolean conyugeACargo, boolean hijosACargo, LocalDate fechaInicio) {
		this.nombre = nombre;
		this.apellido = apellido;
		this.cuil = cuil;
		this.fechaNacimiento= fechaNacimiento;
		this.conyugeACargo = conyugeACargo;
		this.hijosACargo = hijosACargo;
		this.fechaInicio = fechaInicio;
		this.contratos = new ArrayList<Contrato>();
	}

	public String getCuil() {
		return this.cuil;
	}
	
	public void cargarContrato(Contrato contrato) {
		contratos.add(contrato);
	}
	
	public Contrato contratoActual() {
		if (this.contratos.isEmpty()) return null;
		if (this.contratos.size() == 1) {
			return this.contratos.get(0);
		}
		return this.contratos.stream()
				.max((a, b) -> a.compareTo(b))
				.get();
	}
	
	public Recibo generarRecibo() {
		Contrato actual = this.contratoActual();
		if (actual == null || actual.esVencido()) return null;
		int antiguedad = this.fechaInicio.until(LocalDate.now()).getYears();
		double porcentual = antiguedad < 5? 1: antiguedad < 10? 1.3: antiguedad < 15? 1.5: antiguedad < 20? 1.7: 2;
		return new Recibo(this.nombre, this.apellido, this.apellido, antiguedad, LocalDate.now(), actual.calcularMonto() * porcentual);
	}

	public boolean tieneConyugeACargo() {
		return this.conyugeACargo;
	}
	public boolean tieneHijosACargo() {
		return this.hijosACargo;
	}
}
