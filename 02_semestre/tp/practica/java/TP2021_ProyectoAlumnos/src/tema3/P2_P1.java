
package tema3;

import PaqueteLectura.Lector;
import PaqueteLectura.GeneradorAleatorio;

public class P2_P1 {
    public static void main(String[] Args){
        /*
        // Ejer 1
        Triangulo tria= new Triangulo();
        System.out.print("Creacion de Triangulo\n"
                + "  Ingrese Lados: "); tria.setLados(Lector.leerDouble(),Lector.leerDouble(),Lector.leerDouble());
        System.out.print("  Ingrese color de relleno: "); tria.setColorRelleno(Lector.leerString());
        System.out.print("  Ingrese color de linea: "); tria.setColorLinea(Lector.leerString());
        System.out.println("\nEl area del triangulo es: "+tria.calcularArea()+"\n"
                + "El perimetro del triangulo es: "+tria.calcularPerimetro());
        
        // Ejer 2
        Balanza bal= new Balanza();
        bal.iniciarCompra();
        System.out.print("  Ingrese el peso: "); double peso=Lector.leerDouble();
        while (peso!=0){
            System.out.print("  Ingrese precio por Kg: "); bal.registrarProducto(peso,Lector.leerDouble());
            System.out.print("  Ingrese el peso: "); peso=Lector.leerDouble();
        }
        System.out.println("\nDetalle: "+ bal.devolverResumenDeCompra());
        
        // Ejer 3
        Entrenador ent= new Entrenador();
        System.out.print("  Ingrese el nombre: "); ent.setNombre(Lector.leerString());
        System.out.print("  Ingrese el sueldo base: "); ent.setSueldoBase(Lector.leerInt());
        System.out.print("  Ingrese la cantidad de campeonatos ganados: "); ent.setCampeonatosGanados(Lector.leerInt());
        System.out.print("\n"
                + "  Cantidad de campeonatos ganados a sumar: "); ent.setSumarCampeonatosGanados(Lector.leerInt());
        System.out.println("El sueldo a cobrar de "+ent.getNombre()+ " es de: $"+ent.calcularSueldoACobrar());
        
        // Ejer 4
        Circulo cir= new Circulo();
        System.out.print("Creacion de Circulo\n"
                + "  Ingrese radio: "); cir.setRadio(Lector.leerDouble());
        System.out.print("  Ingrese color de relleno: "); cir.setColorRelleno(Lector.leerString());
        System.out.print("  Ingrese color de linea: "); cir.setColorLinea(Lector.leerString());
        System.out.println("\n"
                + "El area del circulo es: "+cir.calcularArea()+"\n"
                + "El perimetro del circulo es: "+cir.calcularPerimetro());
        */
        // Ejer 5
        Balanza2 bal2= new Balanza2();
        bal2.iniciarCompra();
        System.out.print("  Ingrese el peso: "); Producto prod= new Producto(Lector.leerDouble(),"");
        while (prod.getPesoEnKg()!=0){
            System.out.print("  Ingrese la descripcion del producto: "); prod.setDescripcion(Lector.leerString());
            System.out.print("  Ingrese precio por Kg: "); bal2.registrarProducto(prod,Lector.leerDouble());
            System.out.print("  Ingrese el peso: "); prod= new Producto(Lector.leerDouble(),"");
        }
        System.out.println("\n"
                + "Detalle: "+ bal2.devolverResumenDeCompra());
    }
}
