package ar.edu.unlp.info.oo1.ejercicio17;

public class ClienteJuridico extends Cliente {
	private String CUIT;
	private String tipo;
	
	public ClienteJuridico(String telefono, String nombre, String direccion, String CUIT, String tipo) {
		super(telefono, nombre, direccion);
		this.CUIT = CUIT;
		this.tipo = tipo;
	}
	
}
