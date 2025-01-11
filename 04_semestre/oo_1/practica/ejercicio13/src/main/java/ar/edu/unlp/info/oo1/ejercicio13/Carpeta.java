package ar.edu.unlp.info.oo1.ejercicio13;

import java.util.ArrayList;
import java.util.List;

public class Carpeta {
	private List<Email> emails;
	private String nombre;
	
	public Carpeta(String nombre) {
		this.nombre = nombre;
		this.emails = new ArrayList<Email>();
	}
	
	public String getNombre() {
		return this.nombre;
	}
	
	public int tamanio() {
		return this.emails
				.stream()
				.mapToInt(email -> email.tamanio())
				.sum();
	}
	public Carpeta agregarEmail(Email email) {
		this.emails.add(email);
		return this;
	}
	public void agregarAdjuntos(List<Email> email) {
		this.emails.addAll(emails);
	}
	public void eliminarEmail(Email email) {
		this.emails.remove(email);
	}
	public Email mailContiene(String texto) {
		return this.emails
				.stream()
				.filter(email -> email.contiene(texto))
				.findFirst()
				.orElse(null);
	}
}
