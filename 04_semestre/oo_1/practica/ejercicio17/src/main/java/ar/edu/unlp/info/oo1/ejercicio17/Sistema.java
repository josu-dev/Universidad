package ar.edu.unlp.info.oo1.ejercicio17;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Sistema {
	private List<String> telefonosDisponibles;
	private List<Cliente> clientes;
	
	public Sistema () {
		telefonosDisponibles = new ArrayList<String>();
		clientes = new ArrayList<Cliente>();
	}
	
	public void agregarNumero(String telefono) {
		telefonosDisponibles.add(telefono);
	}
	
	public ClienteFisico altaClienteFisico(String nombre, String direccion, Integer dni) {
		ClienteFisico cliente = null;
		if (this.telefonosDisponibles.isEmpty()) {
			return cliente;
		}
		cliente = new ClienteFisico(this.telefonosDisponibles.remove(0), nombre, direccion, dni);
		clientes.add(cliente);
		return cliente;
	}

	public ClienteJuridico altaClienteJuridico(String nombre, String direccion, String CUIT, String tipo) {
		ClienteJuridico cliente = null;
		if (this.telefonosDisponibles.isEmpty()) {
			return cliente;
		}
		cliente = new ClienteJuridico(this.telefonosDisponibles.remove(0), nombre, direccion, CUIT, tipo);
		clientes.add(cliente);
		return cliente;
	}
	
	private boolean registrarLlamada(Llamada llamada) {
		Cliente cliente = this.clientes.stream()
				.filter(c -> c.getTelefono().equals(llamada.telefonoEmisor()))
				.findFirst()
				.orElse(null);
		if (cliente == null) return false;
		cliente.agregarLlamadaEmitida(llamada);
		return true;
	}
	
	public LlamadaLocal registrarLlamadaLocal(LocalDate fecha, Date comienzo, double duracion, String emisor, String receptor) {
		Llamada llamada = new LlamadaLocal(fecha, comienzo, duracion, emisor, receptor);
		if (registrarLlamada(llamada)) return (LlamadaLocal)llamada;
		return null;
	}
	public LlamadaInterurbana registrarLlamadaInterurbana(LocalDate fecha, Date comienzo, double duracion, String emisor, String receptor, double distancia) {
		Llamada llamada = new LlamadaInterurbana(fecha, comienzo, duracion, emisor, receptor, distancia);
		if (registrarLlamada(llamada)) return (LlamadaInterurbana)llamada;
		return null;
	}
	public LlamadaInternacional registrarLlamadaInternacional(LocalDate fecha, Date comienzo, double duracion, String emisor, String receptor, String paisOrigen, String paisDestino) {
		Llamada llamada = new LlamadaInternacional(fecha, comienzo, duracion, emisor, receptor, paisOrigen, paisDestino);
		if (registrarLlamada(llamada)) return (LlamadaInternacional)llamada;
		return null;
	}
	
	public Factura facturarLlamadas(Cliente cliente, LocalDate inicio, LocalDate fin, CuadroTarifario cuadroTarifario) {
		return new Factura(cliente, LocalDate.now(), inicio, fin, cliente.facturar(inicio, fin, cuadroTarifario));
	}
}
