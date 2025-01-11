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
public class CoroSemicircular extends Coro{
    private Corista[] coristas;
    
    public CoroSemicircular( Director director, int cantidadCoristas ) {
        super( director, cantidadCoristas );
        coristas = new Corista[cantidadCoristas];
    }
    
    public void agregarCorista( Corista corista ) {
        int i= 0;
        while (( i< getCantidadCoristas() )&&( coristas[i]== null )) {
            i++;
        }
        if ( i< getCantidadCoristas() ) {
            coristas[i] = corista;
        }
    }
}
