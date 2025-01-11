package tema5;

public abstract class Empleado {
    private String nombre;
    private double sueldoBasico;
    
    public Empleado(){
        
    }
    public Empleado(String unNombre, double unSueldo){
        nombre= unNombre;
        sueldoBasico= unSueldo;
    }
    
    public void setNombre(String unNombre){
        nombre= unNombre;
    }
    public void setSueldoBase(double unSueldo){
        sueldoBasico= unSueldo;
    }
    
    public String getNombre(){
        return nombre;
    }
    public double getSueldoBase(){
        return sueldoBasico;
    }
    
    public abstract double calcularSueldoACobrar();
    
    public String toString(){
        return "Nombre: "+nombre+", sueldo: "+this.calcularSueldoACobrar();
    }
}
