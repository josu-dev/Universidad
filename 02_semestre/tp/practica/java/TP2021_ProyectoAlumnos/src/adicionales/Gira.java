/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package adicionales;

/**
 *
 * @author suare
 */
public class Gira extends Recital{
    private String nombreGira;
    private Fecha[] fechas;
    private int cantidadFechas;
    private int fechaActual;

    public Gira( String nombreBanda, int cantidadTemas, String nombreGira, int cantidadFechas ) {
        super( nombreBanda, cantidadTemas );
        this.nombreGira = nombreGira;
        this.fechas = new Fecha[cantidadFechas];
        this.cantidadFechas = cantidadFechas;
        fechaActual = 0;
    }
    
    public String getNombreGira() {
        return nombreGira;
    }

    public void setNombreGira(String nombreGira) {
        this.nombreGira = nombreGira;
    }

    public Fecha[] getFechas() {
        return fechas;
    }

    public void setFechas(Fecha[] fechas) {
        this.fechas = fechas;
    }

    public int getFechaActual() {
        return fechaActual;
    }

    public void setFechaActual(int fechaActual) {
        this.fechaActual = fechaActual;
    }
    
    public void agregarFecha( Fecha fecha ) {
        int i= 0;
        while ( (i< cantidadFechas)&&(fechas[i]!= null) ) {
            i++;
        }
        if ( i< cantidadFechas ) {
            fechas[i]= fecha;
        }
    }
    
    public void actuar() {
        System.out.println( "Buenas noches " + fechas[fechaActual].getCiudad() );
        super.actuar();
        fechaActual++;
    }
    
    public boolean finalizado() {
        return fechaActual== cantidadFechas;
    }
    
    public double calcularCosto(){
        return cantidadFechas * 30000;
    }
}
