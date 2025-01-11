package tema3;


public class Triangulo {
    private double ladoA,ladoB,ladoC;
    private String colorRelleno,colorLinea;
    
    public Triangulo(){
    }
    
    public Triangulo(double lA, double lB, double lC,String colorR, String colorL){
        ladoA= lA;
        ladoB= lB;
        ladoC= lC;
        colorRelleno= colorR;
        colorLinea= colorL;
    }
    
    public void setLados(double lA, double lB, double lC){
        ladoA= lA;
        ladoB= lB;
        ladoC= lC;
    }
    public void setColorRelleno(String colorR){
        colorRelleno= colorR;
    }
    public void setColorLinea(String colorL){
        colorRelleno= colorL;
    }
    
    public double calcularArea(){
        double s= (ladoA+ladoB+ladoC)/2;
        return Math.sqrt(s*(s-ladoA)*(s-ladoB)*(s-ladoC));
    }
    public double calcularPerimetro(){
        return (ladoA+ladoB+ladoC);
    }
    
    public double getLadoA(){
        return ladoA;
    }
    public double getLadoB(){
        return ladoB;
    }
    public double getLadoC(){
        return ladoC;
    }
    public String getColorRelleno(){
        return colorRelleno;
    }
    public String getColorLinea(){
        return colorLinea;
    }
    
}
