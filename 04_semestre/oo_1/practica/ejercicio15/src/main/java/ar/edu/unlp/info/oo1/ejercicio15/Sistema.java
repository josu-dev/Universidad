package ar.edu.unlp.info.oo1.ejercicio15;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Sistema {

	private List<Usuario> usuarios = new ArrayList<Usuario>();
	private List<Reserva> reservas = new ArrayList<Reserva>();
	
	public Usuario registrarUsuario(String nombre, String direccion, Integer dni) {
		Usuario u = new Usuario(nombre, direccion, dni);
		this.usuarios.add(u);
		return u;
	}
	
	public Propiedad registrarPropiedad(String nombre, String descripcion, String direccion, double precioPorNoche, Usuario dueño) {
		Propiedad p = new Propiedad(nombre, descripcion, direccion, precioPorNoche, dueño);
		dueño.agregarPropiedad(p);
		return p;
	}
	
	public List<Propiedad> propiedadesDisponibles(LocalDate fechaInicio, LocalDate fechaFin) {
		return this.usuarios.stream()
			.flatMap(u -> u.getPropiedades().stream())
			.filter(p -> p.estaDisponible(fechaInicio, fechaFin))
			.toList();
	}
	
	public Reserva hacerReserva(Propiedad propiedad, DateLapse periodo, Usuario inquilino) {
		Reserva reserva=null;
		if (!propiedad.estaDisponible(periodo.getFrom(), periodo.getTo())) {
			return reserva;
		}
		reserva = new Reserva(propiedad, periodo, inquilino);
		this.reservas.add(reserva);
		return reserva;
	}
	
	public double calcularPrecio(Reserva reserva) {
		return reserva.costoTotal();
	}
	
	public boolean eliminarReserva(Reserva reserva) {
		if (!reserva.esEliminable()) {
			return false;
		}
		reserva.eliminar();
		return true;
	}
	
	public List<Reserva> obtenerReservas(Usuario usuario) {
		return this.reservas.stream()
				.filter(r -> r.getInquilino() == usuario)
				.toList();
	}
	
	public double calcularIngresos(Usuario usuario, LocalDate fechaInicio, LocalDate fechaFin) {
		return this.reservas.stream()
				.filter(r -> r.getDueño() == usuario)
				.mapToDouble(r -> r.costo(fechaInicio, fechaFin))
				.sum();
	}
}
