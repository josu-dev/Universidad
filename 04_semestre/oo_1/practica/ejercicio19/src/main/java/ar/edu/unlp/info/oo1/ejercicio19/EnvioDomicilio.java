package ar.edu.unlp.info.oo1.ejercicio19;

public class EnvioDomicilio implements MecanismoEnvio {

	private Mapa mapa = new Mapa();
	@Override
	public double costoAdicional(Cliente cliente, Producto producto) {
		return 50 + mapa.distanciaEntre(cliente.getDireccion(), producto.getDireccion()) * 0.5;
	}

}
