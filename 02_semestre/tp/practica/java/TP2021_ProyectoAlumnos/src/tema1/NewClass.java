
package tema1;

import PaqueteLectura.Lector;

public class NewClass {
    public static void main(String []Args){
        boolean booleanita= true;
        int entera=5,otra=77,ultima;
        double decimales=3.14;
        char caracter,caracter20='j';
        String frase= "esto es un ejemplo";
        int [] vector= new int[15];
        int [][] matriz= new int[15][5];
        
        entera= Lector.leerInt();
        int unaMas= Lector.leerInt();
        System.out.println(entera + " y el otro numero " + unaMas);
        
        
        // = ==
        // > o <  > <
        // >= o <=  >= <=
        //
        //
        if (entera== unaMas){
            System.out.println(entera + " es igual a " + unaMas);
        }
        else if (entera<unaMas){
            System.out.println(" me estoy aburriendo");
        }
        else
            System.out.println(unaMas + "es el mas chico");
        /*
        while (entera<unaMas){
            System.out.println(unaMas);
            unaMas= unaMas -1;
            int tuVariable=0;
            tuVariable+= 5;
            tuVariable+= 1;
            tuVariable*= 5;
            tuVariable/= 5;
            tuVariable%= 5;
        }*/
        
        
        for(int j=1; j<99; j++){
            System.out.println(j);
        }
        
        do {
            System.out.println((entera-1));
            entera-=2;
        } while (entera>0);
        
    }
}
