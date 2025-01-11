package ejercicio6;

import ejercicio3.Arista;
import ejercicio3.Grafo;
import ejercicio3.Vertice;
import estructuras.ListaEnlazadaGenerica;
import estructuras.ListaGenerica;

public class VisitaOslo {
    public ListaGenerica<String> paseoEnBici(
        Grafo<String> lugares, String destino, int maxTiempo,
        ListaGenerica<String> lugaresRestringidos
    ) {
        ListaGenerica<Vertice<String>> vertices = lugares.listaDeVertices();
        vertices.comenzar();
        Vertice<String> v = vertices.proximo();
        while (!vertices.fin() && !v.dato().equals("Ayuntamiento")) {
            v =vertices.proximo();
        }

        return this.dfs(
            lugares, v, destino, lugaresRestringidos,
            maxTiempo, new boolean[vertices.tamanio()]
        );
    }

    private ListaGenerica<String> dfs(
        Grafo<String> g, Vertice<String> v, String destino, 
        ListaGenerica<String> prohibidos, int maxTiempo,
        boolean[] visitados
    ) {
        ListaGenerica<String> result = null;
        if (maxTiempo < 0) return null;
        if (v.dato().equals(destino) && maxTiempo >= 0) {
            result = new ListaEnlazadaGenerica<String>();
            result.agregarFinal(destino);
            return result;
        }
        if (prohibidos.incluye(v.dato())) return null;
        visitados[v.getPosicion()] = true;
        ListaGenerica<Arista<String>> adys = g.listaDeAdyacentes(v);
        adys.comenzar();
        while (!adys.fin() && result == null) {
            Arista<String> ady = adys.proximo();
            Vertice<String> vd = ady.verticeDestino();
            if (!visitados[vd.getPosicion()]) {
                result = dfs(g, vd, destino, prohibidos, maxTiempo - ady.peso(), visitados);
            }
        }
        if (result != null) result.agregarInicio(v.dato());
        return result;
    }
}
