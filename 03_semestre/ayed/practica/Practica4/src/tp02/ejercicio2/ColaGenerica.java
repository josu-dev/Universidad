package tp02.ejercicio2;

public class ColaGenerica<T> {
    private ListaEnlazadaGenerica<T> list = new ListaEnlazadaGenerica<T>();

    public void encolar(T elem){
        list.agregarFinal(elem);
    }

    public T desencolar(){

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
