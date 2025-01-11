package Optimizados;
import java.util.Scanner;

public class Lector {
    // Esta clase reemplaza la libreria de PaqueteLectura.Lector
    // Que sea de utilidad
    
    
    public static String leerString(){
        Scanner sc= new Scanner(System.in);
        return sc.nextLine(); 
    }
    
    
    private static boolean esNumero(char c){
        return (c>='0'&&c<='9');
    }
    private static boolean esOperador(char c){
        return (c=='-'||c=='+');
    }
    public static int leerInt(){
        String str;
        boolean ok=false;
        int i;
        do {
            Scanner sc= new Scanner(System.in);
            str= sc.nextLine();
            i=0;
            if (str.length()>0){
                if (str.length()>1 && esOperador(str.charAt(0)))
                    i++;
                while (i<str.length() && esNumero(str.charAt(i)))
                    i++;
                if (i==str.length())
                    ok= true;
                else
                    System.out.print("Entero invalido, intente nuevamente: ");
            }
        }while (!ok);
        return Integer.parseInt(str);
    }
    
    
    public static double leerDouble(){
        String str;
        boolean ok=false;
        int i,nPuntos;
        do {
            Scanner sc= new Scanner(System.in);
            str= sc.nextLine();
            nPuntos=0;
            i=0;
            if (str.length()>0){
                str= str.replace(',','.');
                if (str.length()>1 && esOperador(str.charAt(0)))
                    i++;
                while (i<str.length() && (esNumero(str.charAt(i))||(str.charAt(i)=='.'))){
                    if (str.charAt(i)=='.')
                        nPuntos++;
                    i++;
                }
                if (i==str.length() && nPuntos<2)
                    ok= true;
                else
                    System.out.print("Real invalido, intente nuevamente: ");
            }
        }while (!ok);
        return Double.parseDouble(str);
    }
    
    
    public static boolean leerBoolean(){
        String str;
        boolean ok=false;
        int i;
        do {
            Scanner sc= new Scanner(System.in);
            str= sc.nextLine();
            if (str.length()>3){
                str= str.toLowerCase();
                if (str.equals("false")||str.equals("true"))
                    ok= true;
                else
                    System.out.print("Booleano invalido, intente nuevamente: ");
            }
            else
                System.out.print("Booleano invalido, intente nuevamente: ");
        }while (!ok);
        return str.equals("true");
    }
}