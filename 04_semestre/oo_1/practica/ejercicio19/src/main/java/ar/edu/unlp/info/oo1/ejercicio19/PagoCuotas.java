package ar.edu.unlp.info.oo1.ejercicio19;

public class PagoCuotas implements FormaPago {

	@Override
	public double precioFinal(Producto producto) {
		return producto.getPrecio() * 1.2;
	}

}
