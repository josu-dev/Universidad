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
public abstract class Recital {
    private String nombreBanda;
    private String[] listaTemas;
    private int cantidadTemas;
    
    public Recital( String nombreBanda, int cantidadTemas ){
        this.nombreBanda = nombreBanda;
        this.listaTemas = new String[cantidadTemas];
        this.cantidadTemas = cantidadTemas;
    }
    
    public String getNombreBanda() {
        return nombreBanda;
    }

    public void setNombreBanda(String nombreBanda) {
        this.nombreBanda = nombreBanda;
    }
    
    public void agregarTema( String nombreTema ){
        int i= 0;
        while ((i< cantidadTemas)&&(listaTemas[i]!= null)) {
            i++;
        }
        if (i< cantidadTemas) {
            listaTemas[i] = nombreTema;
        }
    }
    
    public void actuar () {
        for ( int i= 0; i< cantidadTemas; i++) {
            System.out.println( "y ahora tocaremos " + listaTemas[i] );
        }
    }
    
    public abstract boolean finalizado();
    
    public abstract double calcularCosto();
}
