package ar.edu.unlp.info.oo1.ejercicio4;

public class Circulo implements Cuerpo{
	private double radio;
	private double diametro;
	
	public double getRadio() {
		return radio;
	}
	public void setRadio(double radio) {
		this.radio = radio;
		this.diametro = radio*2;
	}
	public double getDiametro() {
		return diametro;
	}
	public void setDiametro(double diametro) {
		this.diametro = diametro;
		this.radio = diametro/2;
	}
	
	public double getPerimetro() {
		return Math.PI * this.diametro;
	}
	public double getArea() {
		return Math.PI * this.radio * this.radio;
	}
}
