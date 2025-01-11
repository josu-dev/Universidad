package ejercicio1;

public interface Arista<T> {
    public Vertice<T> verticeDestino();
    public int peso();
}