package ejercicio3;

import tp02.ejercicio2.ListaGenerica;
import tp02.ejercicio2.ListaEnlazadaGenerica;
import tp04.ejercicio1.ArbolGeneral;

public class RecorridosAG {
    private void preOrden(ArbolGeneral<Integer> a, Integer n, ListaGenerica<Integer> l) {
        Integer val = a.getDato();
        if (val > n && (val % 2) == 0) {
            l.agregarFinal(val);
        }
        ListaGenerica<ArbolGeneral<Integer>> hijos = a.getHijos();
        hijos.comenzar();
        while (!hijos.fin()) {
            preOrden(hijos.proximo(), n, l);
        }
    }
    public ListaGenerica<Integer> numerosImparesMayoresQuePreOrden(ArbolGeneral<Integer> a, Integer n) {
        ListaGenerica<Integer> resultados = new ListaEnlazadaGenerica<Integer>();
        preOrden(a, n, resultados);
        return resultados;
    }
    private void inOrden(ArbolGeneral<Integer> a, Integer n, ListaGenerica<Integer> l) {
        ListaGenerica<ArbolGeneral<Integer>> hijos = a.getHijos();
        hijos.comenzar();
        preOrden(hijos.proximo(), n, l);

        Integer val = a.getDato();
        if (val > n && (val % 2) == 0) {
            l.agregarFinal(val);
        }

        while (!hijos.fin()) {
            preOrden(hijos.proximo(), n, l);
        }
    }
    public ListaGenerica< Integer > numerosImparesMayoresQueInOrden (ArbolGeneral <Integer> a, Integer n) {
        ListaGenerica<Integer> resultados = new ListaEnlazadaGenerica<Integer>();
        inOrden(a, n, resultados);
        return resultados;
    }
    
    private void postOrden(ArbolGeneral<Integer> a, Integer n, ListaGenerica<Integer> l) {
        ListaGenerica<ArbolGeneral<Integer>> hijos = a.getHijos();
        hijos.comenzar();
        while (!hijos.fin()) {
            preOrden(hijos.proximo(), n, l);
        }

        Integer val = a.getDato();
        if (val > n && (val % 2) == 0) {
            l.agregarFinal(val);
        }
    }
    public ListaGenerica< Integer > numerosImparesMayoresQuePostOrden (ArbolGeneral <Integer> a, Integer n) {
        ListaGenerica<Integer> resultados = new ListaEnlazadaGenerica<Integer>();
        postOrden(a, n, resultados);
        return resultados;
    }

    // no pasaria el parametro del arbol ya q es la misma clase
}
