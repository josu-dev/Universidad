package exer1;

import tp02.ejercicio1.ListaDeEnterosConArreglos;

public class TestListaEnterosConArreglos {
    public static void main(String[] args) {
        ListaDeEnterosConArreglos intList = new ListaDeEnterosConArreglos();
        for (String i : args) {
            intList.agregarFinal(Integer.parseInt(i));
        }

        intList.comenzar();
        while (!intList.fin()) {
            System.out.print(intList.proximo());
        }
    }
}
