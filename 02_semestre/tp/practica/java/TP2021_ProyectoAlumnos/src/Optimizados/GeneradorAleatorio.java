package Optimizados;
import java.util.Random;

public class GeneradorAleatorio {
    // Esta clase reemplaza la libreria de PaqueteLectura.GeneradorAleatorio
    // Que sea de utilidad
    
    
    private static Random rnd=new Random(0);
    
    
    public static void iniciar(){
        rnd= new Random();
    }
    
    
    private static boolean esMayorA0(int n){
        return (n>0 && n<=2000000);
    }
    public static int generarInt(int max){
        if (esMayorA0(max))
            return rnd.nextInt(max+1);
        else {
            System.out.println("El valor maximo ingresado "+max+" es invalido, se reemplazo con 255");
            return rnd.nextInt(256);
        }
    }
    
    
    public static boolean generarBoolean(){
        return rnd.nextBoolean();
    }
    
    
    public static double generarDouble(int max){
        if (esMayorA0(max))
            return (rnd.nextDouble()*max);
        else {
            System.out.println("El valor maximo ingresado "+max+" es invalido, se reemplazo con 255");
            return (rnd.nextDouble()*255);
        }
    }
    
    
    public static String generarString(int tamaño){
        if (!esMayorA0(tamaño)){
            System.out.println("El valor maximo ingresado "+tamaño+" es invalido, se reemplazo con 16");
            tamaño=16;
        }
        String str= "";
        for (int i=0; i<tamaño; i++)
            switch(rnd.nextInt(3)){
                case 0: str+= (char)(48+rnd.nextInt(10));
                        break;
                case 1: str+= (char)(65+rnd.nextInt(26));
                        break;
                case 2: str+= (char)(97+rnd.nextInt(26));
                        break;
            }
        return str;
    }
}
