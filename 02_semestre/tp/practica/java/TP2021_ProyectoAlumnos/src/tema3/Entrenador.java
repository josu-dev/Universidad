
package tema3;

public class Entrenador {
    String nombre;
    double sueldoBase;
    int campeonatosGanados;
    
    public void Entrenador(){
        
    }
    public void Entrenador(String nombreLeido, double sueldoLeido, int campeonatoLeido){
        nombre= nombreLeido;
        sueldoBase= sueldoLeido;
        campeonatosGanados= campeonatoLeido;
    }
    
    public void setNombre(String nombreLeido){
        nombre= nombreLeido;
    }
    public void setSueldoBase(double sueldoLeido){
        sueldoBase= sueldoLeido;
    }
    public void setCampeonatosGanados(int cantidadLeida){
        campeonatosGanados= cantidadLeida;
    }
    public void setSumarCampeonatosGanados(int campeonatosASumar){
        campeonatosGanados+= campeonatosASumar;
    }
    
    public double calcularSueldoACobrar(){
        if (campeonatosGanados<1)
            return sueldoBase;
        else if (campeonatosGanados<5)
            return sueldoBase + 5000;
        else if (campeonatosGanados<11)
            return sueldoBase + 30000;
        else return sueldoBase + 50000;
    }
    public String getNombre(){
        return nombre;
    }
}
