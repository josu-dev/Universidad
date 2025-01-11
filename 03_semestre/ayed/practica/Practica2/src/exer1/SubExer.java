package exer1;

import tp02.ejercicio1.ListaDeEnteros;
import tp02.ejercicio1.ListaDeEnterosEnlazada;

public class SubExer {
    // 1.4 ninguna diferencia
    // 1.7.a Si se puede. Porque es un modelo de implementacion.
    // 1.7.b Dependiendo la estructura en la que se implemente el modelo puede causar ganancias o perdidas de rendimiento
    // 1.7.c Depende la implementacion

    public void PrintList(ListaDeEnteros lista) {
        if (!lista.fin()) {
            int n = lista.proximo();
            PrintList(lista);
            System.out.print(n);
        }
    }

    public ListaDeEnterosEnlazada calcularSucesion(int n) {
        ListaDeEnterosEnlazada lResult = new ListaDeEnterosEnlazada();
        lResult.agregarFinal(n);
        while (n != 1) {
            if (n % 2 == 0) {
                n = n/2;
            }
            else {
                n = 3*n +1;
            }
            lResult.agregarFinal(n);
        }
        return lResult;
    }

    public static void main(String[] args) {
        SubExer f = new SubExer();
        ListaDeEnterosEnlazada l = f.calcularSucesion(6);
        
        l.comenzar();
        while (!l.fin()) {
            System.out.println(l.proximo());
        }
    }
}
