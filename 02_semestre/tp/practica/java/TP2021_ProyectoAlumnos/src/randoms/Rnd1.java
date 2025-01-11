/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package randoms;

import PaqueteLectura.GeneradorAleatorio;
import PaqueteLectura.Lector;

/**
 *
 * @author suare
 */
public class Rnd1 {
    public static void main(String [] args){
        
        GrupoA grupoAlfa= new GrupoA();
        System.out.println("Carga de pacientes Alfa");
        for (int i=0; i<3; i++){
            System.out.print("Ingrese el nombre del paciente: ");
            Paciente p= new Paciente(Lector.leerString());
            // simula la medida inicial, no se aclara como se carga
            p.setUltimaGlucosa(2 + GeneradorAleatorio.generarDouble(4));
            grupoAlfa.agregarPaciente(p);
        }
        
        GrupoB grupoBeta= new GrupoB();
        System.out.println("\nCarga de pacientes Beta");
        for (int i=0; i<4; i++){
            System.out.print("Ingrese el nombre del paciente: ");
            Paciente p= new Paciente(Lector.leerString());
            // simula la medida inicial, no se aclara como se carga
            p.setUltimaGlucosa(2 + GeneradorAleatorio.generarDouble(4));
            grupoAlfa.agregarPaciente(p);
        }
        
        
        System.out.print("\nIngrese la dosis a aplicar a los grupos: ");
        double d= Lector.leerDouble();
        grupoAlfa.aplicarDosis(d);
        grupoBeta.aplicarDosis(d);
    }
}
