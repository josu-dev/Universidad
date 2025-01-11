package ejercicio1;

public class VerticeImplMatrizAdy<T> implements Vertice<T> {
    private T dato;
    private int posicion;

    public VerticeImplMatrizAdy(T dato) {
        this.dato = dato;
    }
    public T dato() {
        return this.dato;
    }
    public int posicion() {
        return this.posicion;
    }
    public void setDato(T dato) {
        this.dato = dato;
    }
    public void setPosicion(int posicion) {
        this.posicion = posicion;
    }
}
