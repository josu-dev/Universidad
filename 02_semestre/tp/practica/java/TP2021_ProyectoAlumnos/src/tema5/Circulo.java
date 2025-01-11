/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema5;

public class Circulo extends Figura{
    private double radio;
    
    public Circulo(){
        super("","");
    }
    public Circulo(double unRadio,String colorRell,String colorLinea){
        super(colorRell,colorLinea);
        radio= unRadio;
    }

    public double getRadio() {
        return radio;
    }

    public void setRadio(double unRadio) {
        this.radio = unRadio;
    }
    
    public double calcularArea(){
        return Math.PI*radio*radio;
    }
    public double calcularPerimetro(){
        return 2*Math.PI*radio;
    }
    public String toString(){
        return "Su radio es: "+radio+", "+super.toString();
    }
}
