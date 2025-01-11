
package tema3;


public class Balanza {
    double monto;
    int cantidad;
    
    public void Balanza(){
        
    }
    public void Balanza(int cantidadCosas, double montoCosa){
        monto= montoCosa;
        cantidad= cantidadCosas;
    }
    
    public void iniciarCompra(){
        monto=0;
        cantidad=0;
    }
    public void registrarProducto(double pesoEnKg, double precioPorKg){
        monto+= pesoEnKg*precioPorKg;
        cantidad++;
    }
    
    public double devolverMontoAPagar(){
        return monto;
    }
    public String devolverResumenDeCompra(){
        return "Total a pagar " + monto + " por la compra de " + cantidad + " productos";
    }
}
