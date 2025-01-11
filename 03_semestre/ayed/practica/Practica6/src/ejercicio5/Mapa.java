package ejercicio5;

import ejercicio3.Arista;
import ejercicio3.Grafo;
import ejercicio3.Vertice;
import estructuras.ListaEnlazadaGenerica;
import estructuras.ListaGenerica;

public class Mapa {
    private Grafo<String> mapaCiudades;

    public Mapa(Grafo<String> grafo) {
        this.mapaCiudades = grafo;
    }

    private Vertice<String> buscarCiudad(String ciudad) {
        ListaGenerica<Vertice<String>> vertices = this.mapaCiudades.listaDeVertices();
        vertices.comenzar();
        while (!vertices.fin()) {
            Vertice<String> v = vertices.proximo();
            if (v.dato().equals(ciudad)) return v;
        }
        return null;
    }

    public ListaGenerica<String> devolverCamino(String ciudad1, String ciudad2) {
        ListaGenerica<Vertice<String>> recorrido = new ListaEnlazadaGenerica<Vertice<String>>(), resultado = new ListaEnlazadaGenerica<Vertice<String>>();
        boolean[] visitados = new boolean[this.mapaCiudades.listaDeVertices().tamanio()];
        ListaGenerica<String> camino = new ListaEnlazadaGenerica<String>();
        for (int i=0; i<visitados.length; i++) visitados[i] = false;
        
        Vertice<String> origen = this.buscarCiudad(ciudad1), destino = this.buscarCiudad(ciudad2);
        if (origen == null || destino == null) return camino;
        
        this.dfs(origen, destino, visitados, recorrido, resultado);

        recorrido.comenzar();
        while (!recorrido.fin()) {
            camino.agregarFinal(recorrido.proximo().dato());
        }
        
        return camino;
    }
    private void dfs(Vertice<String> v, Vertice<String> buscado, boolean[] visitados, ListaGenerica<Vertice<String>> recorrido, ListaGenerica<Vertice<String>> resultado) {
        visitados[v.getPosicion()] = true;
        recorrido.agregarFinal(v);
        if (v == buscado) {
            resultado = recorrido.clonar();
        }
        ListaGenerica<Arista<String>> adyacentes = this.mapaCiudades.listaDeAdyacentes(v);
        adyacentes.comenzar();
        while (!adyacentes.fin() && resultado.esVacia()) {
            Vertice<String> ady = adyacentes.proximo().verticeDestino();
            if (!visitados[ady.getPosicion()]) {
                this.dfs(ady, buscado, visitados, recorrido, resultado);
            }
        }
        recorrido.eliminar(v);
    }

    public ListaGenerica<String> devolverCaminoExeptuando(String ciudad1, String ciudad2, ListaGenerica<String> ciudades) {
        ListaGenerica<Vertice<String>> recorrido = new ListaEnlazadaGenerica<Vertice<String>>(), resultado = new ListaEnlazadaGenerica<Vertice<String>>();
        boolean[] visitados = new boolean[this.mapaCiudades.listaDeVertices().tamanio()];
        ListaGenerica<String> camino = new ListaEnlazadaGenerica<String>();
        for (int i=0; i<visitados.length; i++) visitados[i] = false;
        
        Vertice<String> origen = this.buscarCiudad(ciudad1), destino = this.buscarCiudad(ciudad2);
        if (origen == null || destino == null) return camino;
        
        this.dfsExeptuando(origen, destino, ciudades, visitados, recorrido, resultado);

        recorrido.comenzar();
        while (!recorrido.fin()) {
            camino.agregarFinal(recorrido.proximo().dato());
        }
        
        return camino;
    }
    private void dfsExeptuando(Vertice<String> v, Vertice<String> buscado, ListaGenerica<String> prohibidos, boolean[] visitados, ListaGenerica<Vertice<String>> recorrido, ListaGenerica<Vertice<String>> resultado) {
        if (prohibidos.incluye(v.dato())) return;

        visitados[v.getPosicion()] = true;
        recorrido.agregarFinal(v);
        if (v == buscado) {
            resultado = recorrido.clonar();
        }
        ListaGenerica<Arista<String>> adyacentes = this.mapaCiudades.listaDeAdyacentes(v);
        adyacentes.comenzar();
        while (!adyacentes.fin() && resultado.esVacia()) {
            Vertice<String> ady = adyacentes.proximo().verticeDestino();
            if (!visitados[ady.getPosicion()]) {
                this.dfsExeptuando(v, buscado, prohibidos, visitados, recorrido, resultado);
            }
        }
        recorrido.eliminar(v);
    }
}
