package ar.edu.unlp.info.oo1.ejercicio19;

import java.util.List;

public class Sistema {

	List<Cliente> clientes;
	List<Vendedor> vendedores;
	List<Producto> productos;
	
	public Vendedor registrarVendedor(String nombre, String direccion) {
		Vendedor vendedor = new Vendedor(nombre, direccion);
		vendedores.add(vendedor);
		return vendedor;
	}
	public Vendedor buscarVendedor(String nombre) {
		return this.vendedores.stream()
				.filter(v -> v.getNombre().equals(nombre))
				.findFirst()
				.orElse(null);
	}
	public Cliente registrarCliente(String nombre, String direccion) {
		Cliente cliente = new Cliente(nombre, direccion);
		clientes.add(cliente);
		return cliente;
	}
	public Cliente buscarCliente(String nombre) {
		return this.clientes.stream()
				.filter(v -> v.getNombre().equals(nombre))
				.findFirst()
				.orElse(null);
	}
	
	public Producto agregarProducto(String nombre, String descripcion, double precio, int unidades, Vendedor vendedor) {
		Producto producto = new Producto(nombre, descripcion, precio, unidades, vendedor);
		this.productos.add(producto);
		return producto;
	}
	
	public List<Producto> buscarProducto(String nombre) {
		return this.productos.stream().filter(p -> p.getNombre().equals(nombre)).toList();
	}
	
	public Pedido crearPedido(Cliente cliente, Producto producto, int cantidad, String formaDePago, String mecanismoDeEnvio) {
		if (producto.getUnidades() < cantidad) return null;
		producto.descontar(cantidad);
		FormaPago pago = formaDePago.equals("al contado")? new PagoContado(): new PagoCuotas();
		MecanismoEnvio envio;
		switch (mecanismoDeEnvio) {
			case "retirar en el comercio": {
				envio = new EnvioComercio();
				break;
			}
			case "retirar en sucursal del correo": {
				envio = new EnvioSucursalCorreo();
				break;
			}
			case "exprés a domicilio": {
				envio = new EnvioDomicilio();
				break;
			}
			default : envio = new EnvioDomicilio();
		}
		return new Pedido(cliente, producto, cantidad, pago, envio);
	}
	
	public double costoEnvio(Pedido pedido) {
		return pedido.calcularCosto();
	}
}
