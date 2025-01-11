package tp03.ejercicio4;

import tp03.ejercicio1.ArbolBinario;

public class RedBinariaLlena {
    private ArbolBinario<Integer> red = null;

    public RedBinariaLlena(ArbolBinario<Integer> red) {
        this.red = red;
    }

    private int calcRetardo(ArbolBinario<Integer> red) {
        if (red.esVacio()) return 0;
        int retardoIzq = 0;
        int retardoDer = 0;
        int total = red.getDato();
        if (red.tieneHijoIzquierdo()) {
            retardoIzq = calcRetardo(red.getHijoIzquierdo());
        }
        if (red.tieneHijoDerecho()) {
            retardoDer = calcRetardo(red.getHijoDerecho());
        }
        if (retardoIzq > retardoDer) total += retardoIzq;
        else total += retardoDer;

        return total;
    }

    public int retardoReenvio() {
        int retardo = calcRetardo(this.red);
        return retardo;
    }
}
