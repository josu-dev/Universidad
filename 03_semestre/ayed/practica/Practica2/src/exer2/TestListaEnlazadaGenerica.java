package exer2;

import tp02.ejercicio2.ListaEnlazadaGenerica;

public class TestListaEnlazadaGenerica {
    

    public static void main(String[] args) {
        ListaEnlazadaGenerica<Estudiante> lEstudents = new ListaEnlazadaGenerica<Estudiante>();
        lEstudents.agregarFinal(new Estudiante("1", "Albert", "3a", "pepe@gmail.com", "juanjo"));
        lEstudents.agregarFinal(new Estudiante("2", "Al", "3b", "pepe@gmail.com", "janja"));
        lEstudents.agregarFinal(new Estudiante("3", "Albe", "3c", "pepe@gmail.com", "juanju"));
        lEstudents.agregarFinal(new Estudiante("4", "Albertos", "3d", "pepe@gmail.com", "juonjo"));

        lEstudents.comenzar();
        while (!lEstudents.fin()) {
            System.out.println(lEstudents.proximo().tusDatos());
        }
    }
}
