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
public class Investigador {
    private String nombreYApellido;
    private int categoria;
    private String especialidad;
    private Subsidio[] subsidios;
    
    public Investigador(String unNomYApe, int unaCategoria, String unaEspecialidad) {
        nombreYApellido = unNomYApe;
        categoria = unaCategoria;
        especialidad = unaEspecialidad;
        subsidios = new Subsidio[5];
    }
    
    public void agregarSubsidio( Subsidio unSubsidio ) {
        int i= 0;
        while (( i< 5 )&&( subsidios[i]== null )) {
            i++;
        }
        if ( i< 5 ) {
            subsidios[i] = unSubsidio;
        }
    }
    
    public double getDineroOtorgado() {
        int i= 0;
        double dineroOtorgado= 0;
        while (( i< 5 )&&( subsidios[i]!= null )) {
            if ( subsidios[i].fueOtorgado() ) {
                dineroOtorgado+= subsidios[i].getMonto();
            }
            i++;
        }
        return dineroOtorgado;
    }
    
    public int getCantidadSubsidios() {
        int i= 0;
        while (( i< 5 )&&( subsidios[i]!= null )) {
            i++;
        }
        return i +1;
    }
    
    public String getNombreYApellido() {
        return nombreYApellido;
    }
    
    public void otorgarSubsidios() {
        int i= 0;
        while (( i< 5 )&&( subsidios[i]!= null )) {
            if ( !subsidios[i].fueOtorgado() ) {
                subsidios[i].otorgar();
            }
            i++;
        }
    }
    
    public String toString() {
        return getNombreYApellido() + " " + categoria + " " + getDineroOtorgado() + " ";
    }
}
