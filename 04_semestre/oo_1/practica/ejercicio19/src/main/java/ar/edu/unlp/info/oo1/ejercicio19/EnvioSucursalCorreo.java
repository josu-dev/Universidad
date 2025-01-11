package ar.edu.unlp.info.oo1.ejercicio19;

public class EnvioSucursalCorreo implements MecanismoEnvio {

	@Override
	public double costoAdicional(Cliente cliente, Producto producto) {
		return 50;
	}

}
