package ar.edu.unlp.info.oo1.ejercicio4;

public class Cuerpo3D{
	private double altura;
	private Cuerpo caraBasal;
	
	public void setAltura(double altura) {
		this.altura = altura;
	}
	public double getAltura() {
		return this.altura;
	}
	
	public void setCaraBasal(Cuerpo caraBasal) {
		this.caraBasal = caraBasal;
	}
	public Cuerpo getCaraBasal() {
		return this.caraBasal;
	}
	public double getVolumen() {
		return this.altura * this.caraBasal.getArea();
	}
	public double getSuperficieExterior() {
		return this.altura * this.caraBasal.getPerimetro() + this.caraBasal.getArea() * 2;
	}
}
