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
public class GrupoB extends Grupo{
    
    GrupoB(){
        super();
    }
    
    public void aplicarDosis(double D){
        for (int id=0; id<10; id++){
            if (pacientes[id]!= null && pacientes[id].getUltimaGlucosa()>2.5) {
                pacientes[id].aplicarDosis(D);
            }
        }
    }
    
    public String toString(){
        String str= "Grupo A\n";
        str+= super.toString();
        return str;
    }
}
