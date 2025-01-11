package ejercicio5;

import ejercicio3.Arista;
import ejercicio3.Grafo;
import ejercicio3.Vertice;
import estructuras.ColaGenerica;
import estructuras.ListaEnlazadaGenerica;
import estructuras.ListaGenerica;

public class Recorridos<T> {
    public ListaGenerica<Vertice<T>> dfs(Grafo<T> grafo) {
        ListaGenerica<Vertice<T>> recorrido = new ListaEnlazadaGenerica<Vertice<T>>();
        ListaGenerica<Vertice<T>> vertices = grafo.listaDeVertices();
        boolean[] visitados = new boolean[vertices.tamanio()];

        for (int i=0; i<visitados.length; i++) visitados[i] = false;
        
        vertices.comenzar();
        while (!vertices.fin()) {
            Vertice<T> v = vertices.proximo();
            if (!visitados[v.getPosicion()]) {
                this.dfs(grafo, v, visitados, recorrido);
            }
        }
        return recorrido;
    }
    private void dfs(Grafo<T> g, Vertice<T> v, boolean[] visitados, ListaGenerica<Vertice<T>> recorridos) {
        visitados[v.getPosicion()] = true;
        recorridos.agregarFinal(v);
        ListaGenerica<Arista<T>> adyacentes = g.listaDeAdyacentes(v);
        adyacentes.comenzar();
        while (!adyacentes.fin()) {
            Vertice<T> ady = adyacentes.proximo().verticeDestino();
            if (!visitados[ady.getPosicion()]) {
                this.dfs(g, ady, visitados, recorridos);
            }
        }
    }

    public ListaGenerica<Vertice<T>> bfs(Grafo<T> grafo) {
        ListaGenerica<Vertice<T>> recorrido = new ListaEnlazadaGenerica<Vertice<T>>();
        boolean[] visitados = new boolean[grafo.listaDeVertices().tamanio()];
        ColaGenerica<Vertice<T>> cola = new ColaGenerica<Vertice<T>>();

        for (int i=0; i<visitados.length; i++) visitados[i] = false;
        cola.encolar(grafo.vetice(0));

        while (!cola.esVacia()) {
            Vertice<T> v = cola.desencolar();
            recorrido.agregarFinal(v);
            visitados[v.getPosicion()] = true;
            ListaGenerica<Arista<T>> adys = grafo.listaDeAdyacentes(v);
            adys.comenzar();
            while (!adys.fin()) {
                v = adys.proximo().verticeDestino();
                if (!visitados[v.getPosicion()]) {
                    cola.encolar(v);
                }
            }
            if (cola.esVacia()) {
                for (int i=0; i< visitados.length; i++) {
                    if (!visitados[i]) {
                        cola.encolar(grafo.vetice(i));
                        break;
                    }
                }
            }
        }

        return recorrido;
    }
}
