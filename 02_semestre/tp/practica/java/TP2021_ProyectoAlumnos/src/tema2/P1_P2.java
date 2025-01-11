package tema2;

import PaqueteLectura.GeneradorAleatorio;
import PaqueteLectura.Lector;
/**
 *
 * @author suare
 */
public class P1_P2 {
    public static void main(String[] args) {
        /* Ejer 1
        Persona p= new Persona();
        p.setNombre(Lector.leerString());
        p.setDNI(Lector.leerInt());
        p.setEdad(Lector.leerInt());
        System.out.println(  "Nombre: " + p.getNombre() + ", DNI: " + p.getDNI() + ", edad: " + p.getEdad());
        */
        
        /* Ejer 2
        int CANT_PERSONAS= 5, EDAD_COMP= 65;
        Persona [] vPersonas= new Persona[CANT_PERSONAS];
        int i;
        for (i=0; i<CANT_PERSONAS; i++){
            vPersonas[i]= new Persona();
            System.out.print(  "Nombre: "); vPersonas[i].setNombre(Lector.leerString());
            System.out.print(  "DNI: "); vPersonas[i].setDNI(Lector.leerInt());
            System.out.print(  "Edad: "); vPersonas[i].setEdad(Lector.leerInt());
        }
        int mas65= 0;
        Persona min= new Persona();
        min.setDNI(999999);
        for (i=0; i<CANT_PERSONAS; i++){
            if (vPersonas[i].getEdad()>EDAD_COMP) {
                mas65++;
            }
            if (vPersonas[i].getDNI()<min.getDNI()) {
                min= vPersonas[i];
            }
        }
        System.out.println("  " + mas65 + " son las personas con mas de 65 años");
        System.out.println(min.toString());
        */
        
        /* Ejer 3
        El efecto es que se se referencia muy rapido la informacion
        Que se compara la direccion de los obejetos
        Si el contenido de las strings son iguales
        */
        
        /* Ejer 4
        int CANT_DIAS= 5, CANT_ENTREVISTAS= 2;
        String NOM_CORTE= "ZZZ",nom;
        Persona [][] inscripciones= new Persona[CANT_DIAS][CANT_ENTREVISTAS];
        int i= 0,dia,ent;
        System.out.print("  Nombre: "); nom= Lector.leerString();
        while (!nom.equals(NOM_CORTE)&&(i<(CANT_DIAS*CANT_ENTREVISTAS))) {
            dia= i/CANT_ENTREVISTAS;
            ent= i%CANT_ENTREVISTAS;
            inscripciones[dia][ent]= new Persona();
            inscripciones[dia][ent].setNombre(nom);
            System.out.print("  DNI: "); inscripciones[dia][ent].setDNI(Lector.leerInt());
            System.out.print("  Edad: "); inscripciones[dia][ent].setEdad(Lector.leerInt());
            System.out.println();
            i++;
            System.out.print("  Nombre: "); nom= Lector.leerString();
        }
        for (int j=0; j<i; j++){
            dia= j/CANT_ENTREVISTAS;
            ent= j%CANT_ENTREVISTAS;
            System.out.println("  Para el dia: " + (dia+1) + " posicion: " + (ent +1) + " se entrevistara a " + inscripciones[dia][ent].getNombre());
            System.out.println();
        }
        */
        
        /* Ejer 5
        int CANT_STRINGS= 10;
        String [] palabras= new String[CANT_STRINGS];
        int i;
        for (i=0; i<CANT_STRINGS; i++){
            palabras[i]= Lector.leerString();
        }
        for (i=0; i<CANT_STRINGS; i++){
            System.out.println(palabras[i].charAt(0));
        }
        */
        
        // Ejer 6
        int CANT_PARTIDOS= 20;
        Partido [] campeonato= new Partido[CANT_PARTIDOS];
        String NOM_CORTE= "ZZZ",nomVis;
        int dL=0;
        System.out.print("  Nombre Visitante: "); nomVis= Lector.leerString();
        while ((dL< CANT_PARTIDOS)&&(!nomVis.equals(NOM_CORTE))) {
            campeonato[dL]= new Partido("",nomVis,0,0);
            System.out.print("  Nombre Local: "); campeonato[dL].setLocal(Lector.leerString());
            System.out.print("  Goles Visitante: "); campeonato[dL].setGolesVisitante(Lector.leerInt());
            System.out.print("  Goles Local: "); campeonato[dL].setGolesLocal(Lector.leerInt());
            dL++;
            System.out.print("");
            System.out.print("  Nombre Visitante: "); nomVis= Lector.leerString();
        }
        int winRiver=0, golesBocaLocal=0, empates=0;
        for (int i=0; i<dL; i++){
            if (campeonato[i].getLocal().equals("Boca")) {
                golesBocaLocal+= campeonato[i].getGolesLocal();
            }
            if (campeonato[i].hayEmpate()){
                empates++;
            } else if (campeonato[i].getGanador().equals("River")){
                winRiver++;
            }
        }
        System.out.println("");
        System.out.println("  River gano: " + winRiver);
        System.out.println("  Boca anoto: " + golesBocaLocal);
        System.out.println("  Se empato el " + ((double) empates/dL)); 
    }
}
