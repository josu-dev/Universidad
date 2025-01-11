package tp03.ejercicio3;

import tp02.ejercicio2.ListaEnlazadaGenerica;
import tp03.ejercicio1.ArbolBinario;

public class ContadorArbol {
    private ArbolBinario<Integer> arbol = null;

    public ContadorArbol(ArbolBinario<Integer> arbol) {
        this.arbol = arbol;
    }

    private void inOrden(ListaEnlazadaGenerica<Integer> list,ArbolBinario<Integer> arbol) {
        if (arbol.esVacio()) return;
        if (arbol.tieneHijoIzquierdo()) {
            inOrden(list, arbol.getHijoIzquierdo());
        }
        Integer dato = arbol.getDato();
        if (dato % 2 == 0) {
            list.agregarFinal(dato);
        }
        if (arbol.tieneHijoDerecho()) {
            inOrden(list, arbol.getHijoDerecho());
        }
    }
    private void postOrden(ListaEnlazadaGenerica<Integer> list,ArbolBinario<Integer> arbol) {
        if (arbol.esVacio()) return;
        if (arbol.tieneHijoIzquierdo()) {
            inOrden(list, arbol.getHijoIzquierdo());
        }
        if (arbol.tieneHijoDerecho()) {
            inOrden(list, arbol.getHijoDerecho());
        }
        Integer dato = arbol.getDato();
        if (dato % 2 == 0) {
            list.agregarFinal(dato);
        }
    }
    
    public ListaEnlazadaGenerica<Integer> numerosPares() {
        ListaEnlazadaGenerica<Integer> list = new ListaEnlazadaGenerica<Integer>();
        inOrden(list, this.arbol);
        return list;
    }
}
