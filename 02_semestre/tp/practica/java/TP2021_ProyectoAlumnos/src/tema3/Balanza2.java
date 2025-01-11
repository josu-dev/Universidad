
package tema3;


public class Balanza2 {
    double monto;
    int cantidad;
    String resumen;
    
    public void Balanza2(){
        
    }
    public void Balanza2(int cantidadInicial, double montoInicial, String resumenInicial){
        monto= montoInicial;
        cantidad= cantidadInicial;
        resumen= resumenInicial;
    }
    
    public void iniciarCompra(){
        monto=0;
        cantidad=0;
        resumen= "";
    }
    public void registrarProducto(Producto productoACargar, double precioPorKg){
        double aux= productoACargar.getPesoEnKg()*precioPorKg;
        monto+= aux;
        cantidad++;
        resumen+= productoACargar.getDescripcion()+" "+aux+" - ";
    }
    
    public double devolverMontoAPagar(){
        return monto;
    }
    public String devolverResumenDeCompra(){
        return resumen + "Total a pagar " + monto + " por la compra de " + cantidad + " productos";
    }
}
