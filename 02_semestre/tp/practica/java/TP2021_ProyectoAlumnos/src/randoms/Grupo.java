/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package randoms;

/**
 *
 * @author suare
 */
public abstract class Grupo {
    Paciente [] pacientes;
    
    Grupo() {
        pacientes= new Paciente[10];
    }
    
    public void agregarPaciente(Paciente P){
        int id= 0;
        while (id<10 && pacientes[id]==null){
            id++;
        }
        if (id<10){
            pacientes[id]= P;
        }
    }
    
    public Paciente obtenerPaciente(int id){
        return pacientes[id];
    }
    
    public abstract void aplicarDosis(double D);
    
    public String toString(){
        String str= "";
        for (int id=0; id<10; id++){
            if (pacientes[id]!= null) {
                str+= "Id: " + id + " Nombre: " + pacientes[id].getNombre() +
                        " Ultima glucosa: " + pacientes[id].getUltimaGlucosa() +
                        " Ultima dosis: " + pacientes[id].getUltimaDosis() + "\n";
            }
        }
        return str;
    }
}
