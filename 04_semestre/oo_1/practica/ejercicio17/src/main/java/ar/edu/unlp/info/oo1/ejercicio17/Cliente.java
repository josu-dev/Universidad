package ar.edu.unlp.info.oo1.ejercicio17;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public abstract class Cliente {
	private String telefono, nombre, direccion;
	private List<Llamada> llamadasRealizadas;

	public Cliente(String telefono, String nombre, String direccion) {
		this.telefono = telefono;
		this.nombre = nombre;
		this.direccion = direccion;
		this.llamadasRealizadas = new ArrayList<Llamada>();
	}

	public String getTelefono() {
		return this.telefono;
	}

	public void agregarLlamadaEmitida(Llamada llamada) {
		this.llamadasRealizadas.add(llamada);
	}

	public double facturar(LocalDate inicio, LocalDate fin, CuadroTarifario cuadroTarifario) {
		return this.llamadasRealizadas.stream()
                .mapToDouble(l -> l.getFecha().isBefore(inicio) ? 0
				: l.getFecha().isAfter(fin) ? 0 : l.calcularCosto(cuadroTarifario)).sum();
	}
}
