package ar.edu.unlp.info.oo1.ejercicio13;

import java.util.ArrayList;
import java.util.List;

public class Email {
	private List<Archivo> adjuntos;
	private String titulo, cuerpo;
	
	public Email(String titulo, String cuerpo) {
		this.titulo = titulo;
		this.cuerpo = cuerpo;
		this.adjuntos = new ArrayList<Archivo>();
	}
	public Email agregarAdjunto(Archivo adjunto) {
		this.adjuntos.add(adjunto);
		return this;
	}
	public void agregarAdjuntos(List<Archivo> adjuntos) {
		this.adjuntos.addAll(adjuntos);
	}
	
	public String getTitulo() {
		return this.titulo;
	}
	public String getCuerpo() {
		return this.cuerpo;
	}
	public List<Archivo> adjuntos() {
		return this.adjuntos;
	}
	
	public int tamanio() {
		return this.titulo.length() +
				this.cuerpo.length() +
				this.adjuntos
					.stream()
					.mapToInt(adjunto -> adjunto.tamanio())
					.sum();
	}
	public boolean contiene(String texto) {
		return this.titulo.contains(texto) || this.cuerpo.contains(texto);
	}
}
