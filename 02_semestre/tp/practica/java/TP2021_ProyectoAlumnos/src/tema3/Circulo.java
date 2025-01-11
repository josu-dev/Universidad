
package tema3;

public class Circulo {
    double radio;
    String colorRelleno,colorLinea;
    
    public void Circulo(){
        
    }
    public void Circulo(double radioLeido,String colorRellenoLeido,String colorLineaLeido){
        radio= radioLeido;
        colorRelleno= colorRellenoLeido;
        colorLinea= colorLineaLeido;
    }
    
    public void setRadio(double radioLeido){
        radio= radioLeido;
    }
    public void setColorRelleno(String colorR){
        colorRelleno= colorR;
    }
    public void setColorLinea(String colorL){
        colorRelleno= colorL;
    }
    
    public double calcularArea(){
        return Math.PI*radio*radio;
    }
    public double calcularPerimetro(){
        return Math.PI*radio*2;
    }
    
    public double getRadio(){
        return radio;
    }
    public String getColorRelleno(){
        return colorRelleno;
    }
    public String getColorLinea(){
        return colorLinea;
    }
}
