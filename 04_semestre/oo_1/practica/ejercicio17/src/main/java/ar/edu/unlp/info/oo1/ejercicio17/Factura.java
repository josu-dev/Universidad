package ar.edu.unlp.info.oo1.ejercicio17;

import java.time.LocalDate;

public class Factura {
	private Cliente cliente;
	private LocalDate fecha;
	private LocalDate inicio;
	private LocalDate fin;
	private double monto;
	
	public Factura(Cliente cliente, LocalDate fecha, LocalDate inicio, LocalDate fin, double monto){
		this.cliente = cliente;
		this.fecha = fecha;
		this.inicio = inicio;
		this.fin = fin;
		this.monto = monto;
	}
}
