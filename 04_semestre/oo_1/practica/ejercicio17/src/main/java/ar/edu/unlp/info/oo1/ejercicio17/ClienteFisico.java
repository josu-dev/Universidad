package ar.edu.unlp.info.oo1.ejercicio17;

import java.time.LocalDate;

public class ClienteFisico extends Cliente {
	private Integer dni;
	
	public ClienteFisico(String telefono, String nombre, String direccion, Integer dni) {
		super(telefono, nombre, direccion);
		this.dni = dni;
	}
	
	public double facturar(LocalDate inicio, LocalDate fin, CuadroTarifario cuadroTarifario) {
		return super.facturar(inicio, fin, cuadroTarifario) * 0.9;
	}
}
