package ar.edu.unlp.info.oo1.ejercicio4;

public class Cuadrado  implements Cuerpo{
	private double lado;

	public double getLado() {
		return lado;
	}

	public void setLado(double lado) {
		this.lado = lado;
	}

	public double getPerimetro() {
		return 4 * this.lado;
	}
	public double getArea() {
		return this.lado * this.lado;
	}
}
