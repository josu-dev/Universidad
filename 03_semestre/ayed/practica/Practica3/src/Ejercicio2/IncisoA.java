package Ejercicio2;

import tp02.ejercicio2.ListaEnlazadaGenerica;
import tp03.ejercicio1.ArbolBinario;

public class IncisoA<T> extends ArbolBinario<T> {

    public IncisoA(T dato) {
        super(dato);
	}

    public int contarNodos() {
        int total = 1;
        if (getDato() == null) {
            return 0;
        }
        if (tieneHijoIzquierdo()) {
            total += getHijoIzquierdo().contarHojas();
        }
        if (tieneHijoDerecho()) {
            total += getHijoDerecho().contarHojas();
        }
        return total;
    }

    @Override
    public int contarHojas() {
        int total = 0;
        if (tieneHijoIzquierdo()) {
            total += getHijoIzquierdo().contarHojas();
        }
        if (tieneHijoDerecho()) {
            total += getHijoDerecho().contarHojas();
        }
        if (esHoja()) total += 1;

        return total;
    }

    @Override
    public ArbolBinario<T> espejo() {
        ArbolBinario<T> a = new ArbolBinario<T>(getDato());
        if (esVacio()) return a;
        if (tieneHijoDerecho()) a.agregarHijoIzquierdo(getHijoDerecho().espejo());
        if (tieneHijoIzquierdo()) a.agregarHijoDerecho(getHijoIzquierdo().espejo());
        return a;
    }

    @Override
    public void entreNiveles(int n, int m){
		ListaEnlazadaGenerica<ArbolBinario<T>> cola = new ListaEnlazadaGenerica<ArbolBinario<T>>();
        ArbolBinario<T> arbol = null;
        int lvl = 1;
        cola.agregarFinal(this);
        cola.agregarFinal(null);
        while (!cola.esVacia()) {
            arbol = cola.elemento(1);
            cola.eliminarEn(1);
            if (arbol != null) {
                if ((n <= lvl) && (lvl <= m)) {
                    System.out.println(arbol.getDato());
                }
                if (arbol.tieneHijoIzquierdo()) {
                    cola.agregarFinal(arbol.getHijoIzquierdo());
                }
                if (arbol.tieneHijoDerecho()) {
                    cola.agregarFinal(arbol.getHijoDerecho());
                }
            } else {
                lvl += 1;
                if (! cola.esVacia()) {
                    cola.agregarFinal(null);
                }
            }
        }

	}

    public static void main(String[] args) {
        IncisoA<Integer> a = new IncisoA<Integer>(new Integer(5));

        a.agregarHijoDerecho(new IncisoA<Integer>(new Integer(9)));
        a.agregarHijoIzquierdo(new IncisoA<Integer>(new Integer(3)));
        ArbolBinario<Integer> aEspejo = a.espejo();
        System.out.println(aEspejo.getHijoIzquierdo().getDato() + " " + aEspejo.getDato() + " " + aEspejo.getHijoDerecho().getDato());
    }
}

