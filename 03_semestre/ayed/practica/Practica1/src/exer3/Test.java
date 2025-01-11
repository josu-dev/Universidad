package exer3;

public class Test {
    
    public static void main(String[] args) {
        Estudiante[] estudiantes = new Estudiante[2];
        estudiantes[0] = new Estudiante();
        
        estudiantes[0].setNombre("Pedro");
        estudiantes[0].setApellido("Perez");
        estudiantes[0].setComision("A");
        estudiantes[0].setDireccion("Calle 4 y 69");
        estudiantes[0].setEmail("pedrio@gmail.com");

        estudiantes[1] = new Estudiante();
        estudiantes[1].setNombre("Pedra");
        estudiantes[1].setApellido("Peraz");
        estudiantes[1].setComision("B");
        estudiantes[1].setDireccion("Calle 69 y 4");
        estudiantes[1].setEmail("pedria@gmail.com");

        System.out.println(estudiantes[0].tusDatos());
        System.out.println("\n" + estudiantes[1].tusDatos());
    }
}
