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
public class Proyecto {
    private String nombre;
    private String codigo;
    private String nombreApellidoDirector;
    private Investigador[] investigadores;
    
    public Proyecto( String unNombre, String unCodigo) {
        nombre = unNombre;
        codigo = unCodigo;
        investigadores = new Investigador[50];
    }
    
    public void agregarInvestigador( Investigador unInvestigador ) {
        int i= 0;
        while (( i< 50 )&&( investigadores[i]== null )) {
            i++;
        }
        if ( i< 50 ) {
            investigadores[i] = unInvestigador;
        }
    }
    
    public double dineroTotalOtorgado() {
        int i= 0;
        double dineroTotal= 0;
        while (( i< 50 )&&( investigadores[i]!= null )) {
            dineroTotal+= investigadores[i].getDineroOtorgado();
            i++;
        }
        return dineroTotal;
    }
    
    public int cantidadDeSubsidios(String nombre_y_apellido) {
        int i= 0;
        while (( i< 50 )&&( investigadores[i]!= null )&&( !nombre_y_apellido.equals(investigadores[i].getNombreYApellido()) )) {
            i++;
        }
        return investigadores[i].getCantidadSubsidios();
    }
    
    public void otorgarTodos(String nombre_y_apellido) {
        int i= 0;
        while (( i< 50 )&&( investigadores[i]!= null )&&( !nombre_y_apellido.equals(investigadores[i].getNombreYApellido()) )) {
            i++;
        }
        if (( i<50 )&&( investigadores[i]!= null )) {
            investigadores[i].otorgarSubsidios();
        }
    }
    
    public String toString() {
        int i = 0;
        String mensaje =  nombre + " " + codigo + " " + nombreApellidoDirector + " " + dineroTotalOtorgado() + " ";
        while (( i< 50 )&&( investigadores[i]!= null )) {
            mensaje += investigadores[i].toString();
            i++;
        }
        return mensaje;
    }
    
    public void setDirector( String unNombre_y_unApellido ) {
        nombreApellidoDirector = unNombre_y_unApellido;
    }
    
    public Investigador getInvestigador(String nombre_y_apellido) {
        int i= 0;
        while (( i< 50 )&&( investigadores[i]!= null )&&( !nombre_y_apellido.equals(investigadores[i].getNombreYApellido()) )) {
            i++;
        }
        return investigadores[i];
    }
}
