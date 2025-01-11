
package tema5;

import Optimizados.Lector;

public class P2_P3 {
    public static void main(String [] args){
        /*
        // Ejer 1
        Circulo f1= new Circulo(Lector.leerDouble(),Lector.leerString(),Lector.leerString());
        Triangulo f2= new Triangulo(Lector.leerDouble(),Lector.leerDouble(),Lector.leerDouble(),Lector.leerString(),Lector.leerString());
        Cuadrado f3= new Cuadrado(Lector.leerDouble(),Lector.leerString(),Lector.leerString());

        System.out.println("Circulo: Area: "+f1.calcularArea()+"\n"
                         + "         Perimetro: "+f1.calcularPerimetro()+"\n"
                         + "         "+f1.toString()+"\n"+
                "Triangulo: Area: "+f2.calcularArea()+"\n"
                         + "         Perimetro: "+f2.calcularPerimetro()+"\n"
                         + "         "+f2.toString()+"\n"+
                "Cuadrado: Area: "+f3.calcularArea()+"\n"
                         + "         Perimetro: "+f3.calcularPerimetro()+"\n"
                         + "         "+f3.toString()
                );
        
        // Ejer 2
        Jugador jug = new Jugador(Lector.leerString(),Lector.leerDouble(),Lector.leerInt(),Lector.leerInt());
        System.out.println(jug);

        Entrenador ent = new Entrenador(Lector.leerString(),Lector.leerDouble(),Lector.leerInt());
        System.out.println(ent);
        
        // Ejer 3
        Persona per= new Persona(Lector.leerString(),Lector.leerInt(),Lector.leerInt());
        Trabajador tra= new Trabajador(Lector.leerString(),Lector.leerInt(),Lector.leerInt(),Lector.leerString());
        
        System.out.println("Persona: "+ per+"\n"
                 + "Trabajador: "+tra);
        */
        /* Ejer 4
            imprime 9
            imprime 27
        */
        
        /* Ejer 5
            imprime 3
            porque se hace 3 veces el llamado a el metodo mostrar de visor
        */
        
        // Ejer 6
        VisorFigurasModificado visualizador= new VisorFigurasModificado();
        visualizador.guardar(new Cuadrado(10,"Violeta","Rosa"));
        visualizador.guardar(new Cuadrado(30,"Rojo","Naranja"));
        visualizador.guardar(new Rectangulo(20,10,"Azul","Celeste"));
        
        visualizador.mostrar();
    }
}
