package ar.edu.unlp.info.oo1.ejercicio18;

import java.time.LocalDate;
import java.util.List;

public class Sistema {

	private List<Empleado> nomina;
	
	public void altaEmpleado(String nombre, String apellido, String cuil, LocalDate fechaNacimiento, boolean conyugeACargo, boolean hijosACargo) {
		nomina.add(new Empleado(nombre, apellido, cuil, fechaNacimiento, conyugeACargo, hijosACargo, LocalDate.now()));
	}
	
	public Empleado buscarEmpleado(String cuil) {
		return this.nomina.stream()
				.filter(e -> e.getCuil().equals(cuil))
				.findFirst()
				.orElse(null);
	}
	
	public void darDeBajaEmpleado(Empleado empleado) {
		this.nomina.remove(empleado);
	}
	
	public void cargarContrato(Empleado empleado, LocalDate inicioContrato, LocalDate finContrato, double valorHora, double horasPorMes) {
		empleado.cargarContrato(new ContratoTemporal(empleado, inicioContrato, finContrato, valorHora, horasPorMes));
	}
	public void cargarContrato(Empleado empleado, LocalDate inicioContrato, double sueldoMensual, double montoPorConyuge, double montoPorHijos) {
		empleado.cargarContrato(new ContratoPermanente(empleado, inicioContrato, sueldoMensual, montoPorConyuge, montoPorHijos));
	}
	
	public List<Empleado> empleadosConContratosVencidos() {
		return this.nomina.stream()
				.filter(e -> e.contratoActual().esVencido())
				.toList();
	}
	
	public List<Recibo> generarRecibos() {
		return this.nomina.stream()
				.filter(e -> !e.contratoActual().esVencido())
				.map(e -> e.generarRecibo())
				.toList();
	}
}
