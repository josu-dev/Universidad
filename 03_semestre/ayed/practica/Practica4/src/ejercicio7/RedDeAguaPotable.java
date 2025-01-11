package ejercicio7;

import tp02.ejercicio2.ListaGenerica;
import tp04.ejercicio1.ArbolGeneral;

public class RedDeAguaPotable<T> extends ArbolGeneral<T>  {

    public RedDeAguaPotable(T dato){
        super(dato);
    }
    public RedDeAguaPotable(T dato, ListaGenerica<ArbolGeneral<T>> hijos){
        super(dato, hijos);
    }

    public double minimoCaudal(double caudal) {
        double min = caudal;
        if (this.tieneHijos()) {
            ListaGenerica<ArbolGeneral<T>> hijos = this.getHijos();
            caudal = caudal / hijos.tamanio();
            hijos.comenzar();
            while (!hijos.fin()){
                RedDeAguaPotable<T> red = (RedDeAguaPotable<T>)hijos.proximo();
                min = Math.min(min, red.minimoCaudal(caudal));
            }
        }
        return min;
    }

    public static void main(String[] args) {
        RedDeAguaPotable<Character> miRed = new RedDeAguaPotable<Character>('A');
        RedDeAguaPotable<Character> miRed2 = new RedDeAguaPotable<Character>('D');
        miRed2.agregarHijo(new RedDeAguaPotable<Character>('F'));
        miRed2.agregarHijo(new RedDeAguaPotable<Character>('G'));
        miRed2.agregarHijo(new RedDeAguaPotable<Character>('H'));
        miRed2.agregarHijo(new RedDeAguaPotable<Character>('I'));
        miRed2.agregarHijo(new RedDeAguaPotable<Character>('J'));
        miRed.agregarHijo(new RedDeAguaPotable<Character>('B'));
        miRed.agregarHijo(new RedDeAguaPotable<Character>('C'));
        miRed.agregarHijo(miRed2);
        miRed.agregarHijo(new RedDeAguaPotable<Character>('E'));
        System.out.println(miRed.minimoCaudal(1000));
    }
}
