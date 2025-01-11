package tema5;

public class Persona {
    private String nombre;
    private int DNI,edad;
    
    public Persona(){
        
    }
    public Persona(String suNombre,int suDNI,int suEdad){
        nombre= suNombre;
        DNI= suDNI;
        edad= suEdad;
    }
    
    public void setNombre(String suNombre){
        nombre= suNombre;
    }
    public void setDNI(int suDNI){
        DNI= suDNI;
    }
    public void setEdad(int suEdad){
        edad= suEdad;
    }
    
    public String setNombre(){
        return nombre;
    }
    public int setDNI(){
        return DNI;
    }
    public int setEdad(){
        return edad;
    }
    
    public String toString(){
        return "Mi nombre es "+nombre+",mi DNI es "+DNI+" y tengo "+edad+" años";
    }
}
