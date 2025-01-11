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
public class CoroHileras extends Coro{
    private Corista[][] coristas;
    private int cantidadCoristasHilera;
    
    public CoroHileras( Director director, int cantidadCoristas ) {
        super( director, cantidadCoristas );
        int cantidadCoristasHilera = cantidadCoristas/4;
        coristas = new Corista[4][cantidadCoristasHilera];
    }
    
    public void agregarCorista( Corista corista ) {
        int h= 0, c= 0;
        while (( h< 4 )&&( coristas[h][c]!= null )) {
            
        }
        if ( i< getCantidadCoristas() ) {
            coristas[i] = corista;
        }
    }
}
