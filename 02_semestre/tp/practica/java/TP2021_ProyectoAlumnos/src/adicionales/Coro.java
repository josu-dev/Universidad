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
public abstract class Coro {
    private Director director;
    private String nombre;
    private int cantidadCoristas;
    
    public Coro( Director director, int cantidadCoristas ){
        this.director = director;
        this.cantidadCoristas = cantidadCoristas;
    }
    
    public int getCantidadCoristas() {
        return cantidadCoristas;
    }
    
    public abstract void agregarCorista( Corista corista );
}
