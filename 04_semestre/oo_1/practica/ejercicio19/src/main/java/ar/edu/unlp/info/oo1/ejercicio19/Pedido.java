package ar.edu.unlp.info.oo1.ejercicio19;

public class Pedido {;
	private Cliente cliente;
	private Producto producto;
	private int unidades;
	private FormaPago pago;
	private MecanismoEnvio envio;
	
	public Pedido(Cliente cliente, Producto producto, int unidades, FormaPago pago, MecanismoEnvio envio) {
		this.cliente = cliente;
		this.producto = producto;
		this.unidades = unidades;
		this.pago = pago;
		this.envio = envio;
	}
	
	public double calcularCosto() {
		return this.pago.precioFinal(this.cliente, this.producto) + this.envio.costoAdicional(this.cliente, this.producto);
	}
}
