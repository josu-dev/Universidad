package exer1;

import tp02.ejercicio1.ListaDeEnterosEnlazada;

public class TestListaDeEnterosEnlazada {
    public static void main(String[] args) {
        ListaDeEnterosEnlazada intList = new ListaDeEnterosEnlazada();
        for (String i : args) {
            intList.agregarFinal(Integer.parseInt(i));
        }

        intList.comenzar();
        while (!intList.fin()) {
            System.out.print(intList.proximo());
        }
    }
}
