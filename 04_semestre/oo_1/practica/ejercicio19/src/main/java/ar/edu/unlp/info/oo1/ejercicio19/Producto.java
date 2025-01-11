package ar.edu.unlp.info.oo1.ejercicio19;

public class Producto {
	private String nombre;
	private String descripcion;
	private double precio;
	private int unidades;
	private Vendedor vendedor;
	
	public Producto(String nombre, String descripcion, double precio, int unidades, Vendedor vendedor) {
		this.nombre = nombre;
		this.descripcion = descripcion;
		this.precio = precio;
		this.unidades = unidades;
		this.vendedor = vendedor;
	}
	
	public int getUnidades() {
		return this.unidades;
	}
	public void descontar(int unidades) {
		this.unidades -= unidades;
	}

	public double getPrecio() {
		return this.precio;
	}
	
	public String getNombre() {
		return this.nombre;
	}

	public String getDireccion() {
		return this.vendedor.getDireccion();
	}
}
