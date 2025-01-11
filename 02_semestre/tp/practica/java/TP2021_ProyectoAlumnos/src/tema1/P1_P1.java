package tema1;

import PaqueteLectura.GeneradorAleatorio;
import PaqueteLectura.Lector;

/**
 *
 * @author suare
 */
public class P1_P1 {
    public static void main(String[] args) {
        /* Ejer 1
        int n,res=1;
        n= Lector.leerInt();
        for (int i=n;i>0;i--) {
            res*= i;
        }
        System.out.println("  Para N= " + n + ", el ! es= " + res);
        */
        
        /* Ejer 2
        int INI= 1,FIN= 9, res;
        for (int i=FIN; i>= INI; i--) {
            res= 1;
            for (int j= i; j>1; j--)
                res*= j;
            System.out.println("  !" + i + "= " + res);
        }
        */
        
        /* Ejer 3
        int CANT_JUGADORES= 15;
        double [] vJug= new double[CANT_JUGADORES];
        for (int i=0; i< CANT_JUGADORES; i++) {
            vJug[i]= Lector.leerDouble();
        }
        double altProm= 0;
        for (int i=0; i<CANT_JUGADORES; i++) {
            altProm+= vJug[i];
        }
        altProm/= CANT_JUGADORES;
        int cantAltProm= 0;
        for (int i=0; i<CANT_JUGADORES; i++) {
            if (vJug[i]> altProm) {
                cantAltProm++;
            }
        }
        System.out.println("  La altura promedio es: " + altProm);
        System.out.println("  " + cantAltProm + " es la cantidad de jugadores que sobrepasan la altura promedio");
        */
        
        /* Ejer 4
        int CANT_C= 10, CANT_F=10, MAX_ALE= 200;
        int [][] matriz= new int[CANT_C][CANT_F];
        int i,j;
        for (i=0; i<CANT_F; i++){
            for (j=0; j< CANT_C; j++){
                matriz[i][j]= GeneradorAleatorio.generarInt(MAX_ALE);
            }
        }
        System.out.println("  Matriz:");
        for (i=0; i<CANT_F; i++){
            for (j=0; j< CANT_C; j++){
                System.out.print("  " + matriz[j][i]);
            }
            System.out.println();
        }
        int sumaTotal= 0;
        for (i=2; i<= 9; i++){
            for (j=0; j<= 3; j++){
                sumaTotal+= matriz[i][j];
            }
        }
        System.out.println("  La suma del area es: " + sumaTotal);
        int [] sumaColumnas= new int[CANT_C];
        for (i=0; i< CANT_C; i++){
            sumaColumnas[i]=0;
            for (j=0; j< CANT_F; j++){
                sumaColumnas[i]+= matriz[i][j];
            }
            System.out.println("  Columna " + i + ": " + sumaColumnas[i]);
        }
        int nBuscar;
        nBuscar= Lector.leerInt();
        i=0;
        j=0;
        while ((j<CANT_F)&&(matriz[i][j]!=nBuscar)){
            if (i<CANT_C-1){
                i++;
            } else {
                i=0;
                j++;
            }
        }
        if (j<CANT_F) {
            System.out.println("  Se encontro el " + nBuscar + " en la columna: " + i + " fila: " + j);
        } else {
            System.out.println("  No se encontro el " + nBuscar);
        }
        */
        
        /* Ejer 5
        int PISOS= 8, OFICINAS= 4, PISO_CORTE= 9;
        int [][] edificio= new int[OFICINAS][PISOS];
        int i,j;
        for (j=0; j<PISOS; j++){
            for (i=0; i<OFICINAS; i++){
                edificio[i][j]= 0;
            }
        }
        System.out.print("  Piso: "); j= Lector.leerInt();
        while (j!= PISO_CORTE){
            System.out.print("  Oficina: "); i= Lector.leerInt();
            edificio[i-1][j-1]++;
            System.out.print("  Piso: "); j= Lector.leerInt();
        }
        System.out.println();
        for (j=0; j<PISOS; j++){
            System.out.println("  Piso " + (j+1) +":");
            for (i=0; i<OFICINAS; i++){
                System.out.println("  Oficina " + (i+1) +": " + edificio[i][j]);
            }
        }
        */
        
        // Ejer 6
        int CANT_OPE= 5, OPE_CORTE= 5;
        int [] contOpe= new int[CANT_OPE];
        for (int i=0; i<CANT_OPE; i++){
            contOpe[i]= 0;
        }
        int ope;
        System.out.print("  Operacion: "); ope= Lector.leerInt();
        while (ope!=OPE_CORTE){
            contOpe[ope]++;
            System.out.print("  Operacion: "); ope= Lector.leerInt();
        }
        System.out.println();
        for (int i=0; i<CANT_OPE; i++){
            System.out.println("  La operacion " + i + " fue atendida: " + contOpe[i] + " veces");
        }
    }
}