package ejercicio1;

import estructuras.ListaEnlazadaGenerica;
import estructuras.ListaGenerica;

public class GrafoImplMatrizAdy<T> implements Grafo<T>{
    private int maxVertices;
    private ListaGenerica<Vertice<T>> vertices;
    private int[][] matrizAdy;

    public GrafoImplMatrizAdy(int maxVertices) {
        this.maxVertices = maxVertices;
        this.vertices = new ListaEnlazadaGenerica<Vertice<T>>();
        this.matrizAdy = new int[this.maxVertices][this.maxVertices];
    }
    private VerticeImplMatrizAdy<T> buscarVertice(Vertice<T> v) {
        return (VerticeImplMatrizAdy<T>)this.vertices.elemento(v.posicion() + 1);
    }
    public void agregarVertice(Vertice<T> v) {
        this.vertices.agregarEn(v, v.posicion() - 1);
    }
    public void eliminarVertice(Vertice<T> v) {
        for (var i= 0; i<this.maxVertices;i++) {
            this.matrizAdy[v.posicion() - 1][i] = 0;
        }
        this.vertices.eliminar(v);
    }
}
