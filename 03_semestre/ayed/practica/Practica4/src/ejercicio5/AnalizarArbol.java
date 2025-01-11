package ejercicio5;

import tp02.ejercicio2.ColaGenerica;
import tp02.ejercicio2.ListaGenerica;
import tp04.ejercicio1.ArbolGeneral;

public class AnalizarArbol {
    public int devolverMaximoPromedio (ArbolGeneral<AreaEmpresa>arbol) {
        ColaGenerica<ArbolGeneral<AreaEmpresa>> cola = new ColaGenerica<ArbolGeneral<AreaEmpresa>>();
        cola.encolar(arbol);
        cola.encolar(null);
        Integer cant=0, suma = 0, prom = 0;
        while (!cola.esVacia()) {
            ArbolGeneral<AreaEmpresa> a = cola.desencolar();
            if (a != null) {
                cant ++;
                suma += a.getDato().getTardanza();
                ListaGenerica<ArbolGeneral<AreaEmpresa>> hijos = a.getHijos();
                hijos.comenzar();
                while (!hijos.fin()) {
                    cola.encolar(hijos.proximo());
                }
            }
            else {
                if (!cola.esVacia()) {
                    cola.encolar(null);
                }
                if ((Math.round(suma/cant)) > prom)
                    prom = Math.round(suma/cant);
                cant = 0;
                suma = 0;
            }
        }
		return prom;
    }

    
}
