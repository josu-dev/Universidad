package ar.edu.unlp.info.oo1.ejercicio13;

import java.util.ArrayList;
import java.util.List;

public class ClienteDeCorreo {
	private List<Carpeta> carpetas;
	
	public ClienteDeCorreo() {
		this.carpetas = new ArrayList<Carpeta>();
		this.carpetas.add(new Carpeta("Inbox"));
	}
	public void crearCarpeta(String nombre) {
		this.carpetas.add(new Carpeta(nombre));
	}
	public void agregarCarpeta(Carpeta carpeta) {
		this.carpetas.add(carpeta);
	}
	public void eliminarCarpeta(Carpeta carpeta) {
		this.carpetas.remove(carpeta);
	}
	
	private Carpeta getInbox() {
		return this.carpetas.get(0);
	}
	public void recibir(Email email) {
		this.getInbox()
			.agregarEmail(email);
	}
	public void mover(Email email, Carpeta origen, Carpeta destino) {
		origen.eliminarEmail(email);
		destino.agregarEmail(email);
	}
	public Email buscar(String texto) {
		Carpeta result = this.carpetas
			.stream()
			.filter(carpeta -> carpeta.mailContiene(texto) != null)
			.findFirst()
			.orElse(null);
		return result == null?
				null:
				result.mailContiene(texto);
	}
	public Email buscarEnhanced(String texto) {
		for(Carpeta carpeta : this.carpetas) {
			Email result = carpeta.mailContiene(texto);
			if (result != null) return result;
		}
		return null;
	}
	public Integer espacioOcupado() {
		return this.carpetas
				.stream()
				.mapToInt(carpeta -> carpeta.tamanio())
				.sum();
	}
	
}
