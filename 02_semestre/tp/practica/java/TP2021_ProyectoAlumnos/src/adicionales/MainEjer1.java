/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package adicionales;

import Optimizados.Lector;

/**
 *
 * @author suare
 */
public class MainEjer1 {
    public static void main( String[] args) {
        String nombreProyecto, codigoProyecto;
        System.out.print( "Ingrese el nombre del proyecto: "); nombreProyecto = Lector.leerString();
        System.out.print( "Ingrese el codigo del proyecto: "); codigoProyecto = Lector.leerString();
        
        Proyecto proyec = new Proyecto( nombreProyecto, codigoProyecto );
        System.out.print( "Ingrese el nombre y apellido del director: "); proyec.setDirector( Lector.leerString() );
        
        System.out.print( "Agregar investigadores: ");
        String nombreYApellido1, nombreYApellido2, especialidad;
        int categoria;
        
        System.out.print( "Ingrese el nombre y apellidod el investigador: "); nombreYApellido1 = Lector.leerString();
        System.out.print( "Ingrese la categoria: "); categoria = Lector.leerInt();
        System.out.print( "Ingrese la especialidad: "); especialidad = Lector.leerString();

        Investigador inves= new Investigador(nombreYApellido1, categoria, especialidad);
        proyec.agregarInvestigador(inves);
        
        System.out.print( "Ingrese el nombre y apellidod el investigador: "); nombreYApellido2 = Lector.leerString();
        System.out.print( "Ingrese la categoria: "); categoria = Lector.leerInt();
        System.out.print( "Ingrese la especialidad: "); especialidad = Lector.leerString();

        inves= new Investigador(nombreYApellido2, categoria, especialidad);
        proyec.agregarInvestigador(inves);
        
        double monto;
        String motivo;
        System.out.print( "Ingrese el monto del subsidio: "); monto = Lector.leerDouble();
        System.out.print( "Ingrese motivo del subsidio: "); motivo = Lector.leerString();
        proyec.getInvestigador(nombreYApellido1).agregarSubsidio( new Subsidio( monto, motivo ));
        
        System.out.print( "Ingrese el monto del subsidio: "); monto = Lector.leerDouble();
        System.out.print( "Ingrese motivo del subsidio: "); motivo = Lector.leerString();
        proyec.getInvestigador(nombreYApellido2).agregarSubsidio( new Subsidio( monto, motivo ));
        
        proyec.otorgarTodos(nombreYApellido1);
        
        System.out.print( proyec.toString() );
    }
    
}
