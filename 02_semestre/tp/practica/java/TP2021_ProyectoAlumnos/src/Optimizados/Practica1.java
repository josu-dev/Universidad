//  Pa', que estas esperando para optimizar tu vida?
//  @author Optimization Gang

package Optimizados;

import PaqueteLectura.GeneradorAleatorio;
//import PaqueteLectura.Lector;

public class Practica1 {
    public static void main(String[] args){
    // Parte 1
        // Ejer 1
        for(int f= Lector.leerInt(),i=1,n=1;n<=f;i=i*n++)
            if(n==f)System.out.println(i*n);
        
        // Ejer 2
        for(int i=1,n=1;n<=9;i=i*n++, System.out.println(i));
        
        // Ejer 3
        int[]a= new int[17];
        for(int i=0;i<15;a[i]=Lector.leerInt(),a[15]+=a[i],i++) ;
        System.out.println(a[15]/(double)15);
        for(int i=0;i<15;i++)
            if (a[i]>(a[15]/(double)15)) a[16]++; 
        System.out.println(a[16]);
        
        // Ejer 4
        int [][] matriz= new int[10][10];
        int [] v= new int[13];
        for (int i=0; i<100; matriz[i/10][i%10]= GeneradorAleatorio.generarInt(200), i++);
        for (int i=0; i<100; i++){
                System.out.print("  " + matriz[i%10][i/10]);
                if (((i%10)>=0)&&((i%10)<=3)&&((i/10)>=2)&&((i/10)<=9))
                    v[10]+= matriz[i%10][i/10];
                v[i%10]+= matriz[i%10][i/10];
                if ((i%10)==9)
                    System.out.println();
            }
        System.out.println("Suma Area: "+v[10]);
        for (v[11]= Lector.leerInt(),v[12]=0;(v[12]<100)&&(matriz[v[12]/10][v[12]%10]!=v[11]);v[12]++);
        if (v[12]<100)
            System.out.println("Encontrado, colu: " + (v[12]/10) + " fila: " + (v[12]%10));
        else
            System.out.println("No encontrado");
        
        // Ejer 5
        int [][] edi= new int[8][4];
        for (int p= Lector.leerInt(),o;(p!=9);o= Lector.leerInt(),edi[p-1][o-1]++,p= Lector.leerInt());
        for (int i=0;i<32;System.out.println("Piso: " + (i/4+1) + ", oficina: " + (i%4+1) +", concurrieron: " + edi[i/4][i%4]),i++);
        
        //Ejer 6
        int [] opes= new int[7];
        for (opes[5]= Lector.leerInt();(opes[5]!=5);opes[opes[5]]++,opes[5]= Lector.leerInt());
        for (opes[5]=0, opes[6]=0;(opes[6]<5);System.out.println("Operacion " + opes[6] + ": " + opes[opes[6]]),opes[6]++)
            if (opes[opes[6]]>opes[opes[5]]) opes[5]=opes[6];
        System.out.println("La operacion mas solicitada fue la " + opes[5]);
        
    // Parte 2
        
        // Ejer 1
        System.out.println(new Persona(Lector.leerString(),Lector.leerInt(),Lector.leerInt()).toString());
        
        // Ejer 2
        Persona [] hs= new Persona[15];
        for (int i=0; i<15;hs[i]= new Persona(Lector.leerString(),Lector.leerInt(),Lector.leerInt()), i++);
        int c65=0,hm=0;
        for (int i=0; i<15; i++){
            if (hs[i].getEdad()>65) c65++;
            if (hs[i].getDNI()<hs[hm].getDNI()) hm=i;
        }
        System.out.println(c65 + "mayores a 65, " + hs[hm].toString());
        
        // Ejer 4
        Persona [][] ins= new Persona[5][8];
        int t= 0;
        for (String s=Lector.leerString();(t<40)&&(!s.equals("ZZZ"));ins[t/8][t%8]=new Persona(s,Lector.leerInt(),Lector.leerInt()),System.out.println("Turno dia:"+(t/8+1)+" pos:"+(t%8+1)),s=Lector.leerString(),t++);
        for (int j=0; j<t; System.out.println("  Dia: " + (j/8+1) + " posicion: " + (j%8 +1) + " se entrevistara a " + ins[j/8][j%8].getNombre()), j++);
        
        // Ejer 5
        String [] palabras= new String[10];
        for (int i=0; i<10;palabras[i]= Lector.leerString(), i++);
        for (int i=0; i<10;System.out.print(palabras[i].charAt(0)), i++);
        
        // Ejer 6
        Partido [] campeonato= new Partido[20];
        int dL=0, winRiver=0, gBoca=0, empates=0;
        for (String vis=Lector.leerString();(dL<20)&&(!vis.equals("ZZZ"));vis=Lector.leerString(),dL++)
            campeonato[dL]= new Partido(Lector.leerString(),vis,Lector.leerInt(),Lector.leerInt());
        for (int i=0; i<dL; i++){
            if (campeonato[i].getLocal().equals("Boca"))
                gBoca+= campeonato[i].getGolesLocal();
            if (campeonato[i].hayEmpate())
                empates++;
            else if (campeonato[i].getGanador().equals("River"))
                winRiver++;
        }
        System.out.println("River gano: " + winRiver + ", Boca anoto: " + gBoca + ", se empato el " + ((double) empates/dL) + "%");
    }
}
