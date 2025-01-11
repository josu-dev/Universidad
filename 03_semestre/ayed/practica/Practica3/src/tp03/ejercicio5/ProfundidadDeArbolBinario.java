package tp03.ejercicio5;

import tp02.ejercicio2.ListaEnlazadaGenerica;
import tp03.ejercicio1.ArbolBinario;

public class ProfundidadDeArbolBinario {
    private ArbolBinario<Integer> arbol = null;

    public ProfundidadDeArbolBinario(ArbolBinario<Integer> arbol) {
        this.arbol = arbol;
    }
    
    public int sumaElementosProfundidad(int p) {
        int suma = 0, lvl = 1;
        ListaEnlazadaGenerica<ArbolBinario<Integer>> cola = new ListaEnlazadaGenerica<ArbolBinario<Integer>>();
        ArbolBinario<Integer> arbol = null;
        cola.agregarFinal(this.arbol);
        cola.agregarFinal(null);
        while (!cola.esVacia()) {
            arbol = cola.elemento(1);
            cola.eliminarEn(1);
            if (arbol != null) {
                if ((lvl == p)) {
                    suma += arbol.getDato();
                }
                if (arbol.tieneHijoIzquierdo()) {
                    cola.agregarFinal(arbol.getHijoIzquierdo());
                }
                if (arbol.tieneHijoDerecho()) {
                    cola.agregarFinal(arbol.getHijoDerecho());
                }
            } else {
                lvl += 1;
                if (lvl > p) break;
                if (! cola.esVacia()) {
                    cola.agregarFinal(null);
                }
            }
        }
        return suma;
    }

    public static void main(String[] args) {
        ArbolBinario<Integer> a = new ArbolBinario<Integer>(new Integer(5));
        ArbolBinario<Integer> aIzq = new ArbolBinario<Integer>(new Integer(10));

        aIzq.agregarHijoDerecho(new ArbolBinario<Integer>(new Integer(76)));
        aIzq.agregarHijoIzquierdo(new ArbolBinario<Integer>(new Integer(4)));

        a.agregarHijoDerecho(aIzq);
        a.agregarHijoIzquierdo(new ArbolBinario<Integer>(new Integer(20)));
        
        ProfundidadDeArbolBinario medir = new ProfundidadDeArbolBinario(a);
        System.out.println(medir.sumaElementosProfundidad(4));
    }
}
