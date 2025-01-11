package tema5;

public class Triangulo extends Figura{
    private double l1,l2,l3;
    
    public Triangulo(){
        super("","");
    }
    public Triangulo(double Lado1,double Lado2,double Lado3,String colorRell,String colorLinea){
        super(colorRell,colorLinea);
        l1= Lado1;
        l2= Lado2;
        l3= Lado3;
    }

    public double getL1() {
        return l1;
    }

    public void setL1(double l1) {
        this.l1 = l1;
    }

    public double getL2() {
        return l2;
    }

    public void setL2(double l2) {
        this.l2 = l2;
    }

    public double getL3() {
        return l3;
    }

    public void setL3(double l3) {
        this.l3 = l3;
    }
    
    public double calcularArea(){
        double s= (l1+l2+l3)/2;
        return Math.sqrt(s*(s-l1)*(s-l2)*(s-l3));
    }
    public double calcularPerimetro(){
        return l1+l2+l3;
    }
    public String toString(){
        return "Sus lados son: "+l1+","+l2+","+l3+", "+super.toString();
    }
}
