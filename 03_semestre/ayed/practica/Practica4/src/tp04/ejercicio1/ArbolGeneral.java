package tp04.ejercicio1;

import tp02.ejercicio2.ColaGenerica;
import tp02.ejercicio2.ListaEnlazadaGenerica;
import tp02.ejercicio2.ListaGenerica;

public class ArbolGeneral<T> {

	private T dato;

	private ListaGenerica<ArbolGeneral<T>> hijos ;

	public T getDato() {
		return dato;
	}

	public void setDato(T dato) {
		this.dato = dato;
	}

	public void setHijos(ListaGenerica<ArbolGeneral<T>> hijos) {
		if (hijos==null)
			this.hijos = new ListaEnlazadaGenerica<ArbolGeneral<T>>();
		else
			this.hijos = hijos;
	}

	public ArbolGeneral(T dato) {
		this.dato = dato;
        this.hijos =  new ListaEnlazadaGenerica<ArbolGeneral<T>>();
    }

	public ArbolGeneral(T dato, ListaGenerica<ArbolGeneral<T>> hijos) {
		this(dato);
		if (hijos==null)
			this.hijos = new ListaEnlazadaGenerica<ArbolGeneral<T>>();
		else
			this.hijos = hijos;
	}

	public ListaGenerica<ArbolGeneral<T>> getHijos() {
		return this.hijos;
	}

	public void agregarHijo(ArbolGeneral<T> unHijo) {

		this.getHijos().agregarFinal(unHijo);
	}

	public boolean esHoja() {

		return !this.tieneHijos();
	}
	
	public boolean tieneHijos() {
		return !this.hijos.esVacia();
	}
	
	public boolean esVacio() {

		return this.dato == null && !this.tieneHijos();
	}

	

	public void eliminarHijo(ArbolGeneral<T> hijo) {
		if (this.tieneHijos()) {
			ListaGenerica<ArbolGeneral<T>> hijos = this.getHijos();
			if (hijos.incluye(hijo)) 
				hijos.eliminar(hijo);
		}
	}
	
	public ListaEnlazadaGenerica<T> preOrden() {
		return null;
	}
	
	public Integer altura() {
		// Falta implementar..
        ColaGenerica<ArbolGeneral<T>> cola = new ColaGenerica<ArbolGeneral<T>>();
        cola.encolar(this);
        cola.encolar(null);
        Integer altura = 0;
        while (!cola.esVacia()) {
            ArbolGeneral<T> a = cola.desencolar();
            if (a != null) {
                ListaGenerica<ArbolGeneral<T>> hijos = a.getHijos();
                hijos.comenzar();
                while (!hijos.fin()) {
                    cola.encolar(hijos.proximo());
                }
            }
            else {
                if (!cola.esVacia()) {
                    cola.encolar(null);
                }
                altura++;
            }
        }
		return altura;
	}

	public Integer nivel(T dato) {
		ColaGenerica<ArbolGeneral<T>> cola = new ColaGenerica<ArbolGeneral<T>>();
        cola.encolar(this);
        cola.encolar(null);
        Integer nivel = 0;
        while (!cola.esVacia()) {
            ArbolGeneral<T> a = cola.desencolar();
            if (a != null) {
                if (a.getDato() == dato) break;
                ListaGenerica<ArbolGeneral<T>> hijos = a.getHijos();
                hijos.comenzar();
                while (!hijos.fin()) {
                    cola.encolar(hijos.proximo());
                }
            }
            else {
                if (!cola.esVacia()) {
                    cola.encolar(null);
                }
                nivel++;
            }
        }
		return nivel;
	}

	public Integer ancho() {
		// Falta implementar..
		ColaGenerica<ArbolGeneral<T>> cola = new ColaGenerica<ArbolGeneral<T>>();
        cola.encolar(this);
        cola.encolar(null);
        Integer ancho = 0, max = 0;
        while (!cola.esVacia()) {
            ArbolGeneral<T> a = cola.desencolar();
            if (a != null) {
                ancho++;
                ListaGenerica<ArbolGeneral<T>> hijos = a.getHijos();
                hijos.comenzar();
                while (!hijos.fin()) {
                    cola.encolar(hijos.proximo());
                }
            }
            else {
                if (!cola.esVacia()) {
                    cola.encolar(null);
                }
                if (ancho > max)
                    max = ancho;
                ancho = 0;
            }
        }
		return max;
	}

    private ArbolGeneral<T> buscarNodo(T n) {
        if (this.getDato()== n) {
            return this;
        }
        if (!this.tieneHijos()) {
            return null;
        }
        
        ListaGenerica<ArbolGeneral<T>> hijos = this.getHijos();
        hijos.comenzar();
        while (!hijos.fin()) {
                ArbolGeneral<T> a = hijos.proximo().buscarNodo(n);
                if (a != null && a.getDato() == n) return a;
        }
        return null;
    }

    public Boolean esAncestro(T a, T b) {
        ArbolGeneral<T> esA = this.buscarNodo(a);
        if (esA == null) return false;
        ArbolGeneral<T> esB = esA.buscarNodo(b);
        return esB != null;
    }
    public Boolean esDescendiente(T a, T b) {
        ArbolGeneral<T> esB = this.buscarNodo(b);
        if (esB == null) return false;
        ArbolGeneral<T> esA = esB.buscarNodo(a);
        return esA != null;
    }

    public T postAncestro(T a, T b) {
        T dato = this.getDato();

        if (dato == b) return b;
        if (!this.tieneHijos()) return dato;

        ListaGenerica<ArbolGeneral<T>> hijos = this.getHijos();
        hijos.comenzar();
        while (!hijos.fin()) {
            dato = postAncestro(a, b);
            
            if (dato == null) return null;
            if (dato == b) {
                if (this.getDato() == a) return null;
                return b;
            }
        }
        return dato;
    }
    public Boolean esAncestroSuperComplicado(T a, T b) {
        return postAncestro(a, b) == null;
    }
}