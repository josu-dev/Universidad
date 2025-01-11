
package tema4;

import PaqueteLectura.Lector;

public class P2_P2 {
    public static void main(String[] Args){
        /*
        // Ejer 3
        Libro2 lib= new Libro2("Java: A Beginner's Guide","Mcgraw-Hill", 2014, new Autor("Herbert Schildt","Buen tipo"), "978-0071809252", 21.72);
        System.out.println(lib.toString());
        System.out.println("Precio del libro: " +lib.getPrecio());
        System.out.println("Año edición del libro: " +lib.getAñoEdicion());
        
        // Ejer 4
        Micro mic= new Micro("ABC123","Mar del Plata","5:00");
        System.out.print("Ingrese numero de asiento: "); int n= Lector.leerInt();
        while (!(n==-1)&&!mic.getEstaLleno()){
            if (mic.getAsientoEnRango(n)){
                if (mic.getEstaDisponible(n)){
                    mic.setOcuparAsiento(n);
                    System.out.println("El asiento "+n+" fue ocupado con exito");
                }
                else {
                    System.out.println("El asiento "+n+" ya esta ocupado\n"
                            + "El primer asiento disponible es el "+mic.getPrimerAsientoLibre());
                }
            }
            else
                System.out.println("Ingrese un asiento entre 1 y 20");
            System.out.print("Ingrese numero de asiento: "); n= Lector.leerInt();
        }
        
        System.out.println("La cantidad de asientos ocupados es: "+mic.getCantAsientosOcupados());
        */
        // Ejer 5
        Flota flot= new Flota();
        System.out.print("Ingrese una patente: "); String patente=Lector.leerString(),destino;
        while (!patente.equals("ZZZ000")&&(!flot.getFlotaCompleta())){
            System.out.print("Ingrese destino: "); destino= Lector.leerString();
            System.out.print("Ingrese horario de salida: "); flot.setMicro(new Micro(patente,destino,Lector.leerString()));
            System.out.print("\n"
                    + "Ingrese una patente: "); patente=Lector.leerString();
        }
        
        System.out.print("\n"
                    + "Ingrese patente del micro a eliminar: "); patente= Lector.leerString();
        flot.getEliminarMicro(patente);
        if (flot.getBuscarMicroPatente(patente)==null)
            System.out.print("El micro de patente "+patente+" ya no se encuentra en la flota");
        else
            System.out.print("El micro de patente "+patente+" esta en la flota");
        
        System.out.print("\n"
                    + "Ingrese el destino del micro a buscar: "); destino= Lector.leerString();
        System.out.println("La patente del micro buscado es "+flot.getBuscarMicroDestino(destino).getPatente());
        
    }
}
