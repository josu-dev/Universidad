package tp02.ejercicio3;

import tp02.ejercicio2.ListaEnlazadaGenerica;

public class PilaGenerica<T> {
    private ListaEnlazadaGenerica<T> list = new ListaEnlazadaGenerica<T>();

    public void apilar(T elem){
        list.agregarInicio(elem);
    }

    public T desapilar(){
        T elem = list.elemento(1);
        list.eliminarEn(1);
        return elem;
    }

    public T tope(){
        T elem = list.elemento(1);
        return elem;
    }

    public boolean esVacia(){
        return list.esVacia();
    }
}
