package ar.edu.unlp.info.oo1.ejercicio17;

import java.util.HashMap;

public class CuadroTarifario {
	private HashMap<String, Double> precioPorPaisDiurno = new HashMap<String, Double>();
	private HashMap<String, Double> precioPorPaisNocturno = new HashMap<String, Double>();

	public void registrarPais(String pais, double precioDiurno, double precioNocturno) {
		precioPorPaisDiurno.put(pais, precioDiurno);
		precioPorPaisNocturno.put(pais, precioNocturno);
	}

	public double costoPorMinuto(LlamadaLocal llamada) {
		return 1;
	}

	public double costoPorMinuto(LlamadaInterurbana llamada) {
		if (llamada.getDistancia() > 500)
			return 3;
		if (llamada.getDistancia() >= 100)
			return 2.5;
		return 2;
	}

	public double costoPorMinuto(LlamadaInternacional llamada) {
		if (8 <= llamada.getComienzo().getHours() && llamada.getComienzo().getHours() < 20) {
			return precioPorPaisDiurno.get(llamada.getPaisOrigen());
		}
		return precioPorPaisNocturno.get(llamada.getPaisOrigen());
	}
}
