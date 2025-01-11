package tema5;

public class Entrenador extends Empleado{
    private int campeonatosGanados;
    
    public Entrenador(){
        super();
    }
    public Entrenador(String unNombre,double unSueldo,int cantCampeonatos){
        super(unNombre,unSueldo);
        campeonatosGanados= cantCampeonatos;
    }
    
    public void setCampeonatosGanados(int cantCampeonatos){
        campeonatosGanados= cantCampeonatos;
    }
    
    public int getCampeonatosGanados(){
        return campeonatosGanados;
    }
    
    public double calcularSueldoACobrar(){
        if (campeonatosGanados<1)
            return getSueldoBase();
        else if (campeonatosGanados<5)
            return getSueldoBase() + 5000;
        else if (campeonatosGanados<11)
            return getSueldoBase() + 30000;
        else return getSueldoBase() + 50000;
    }
}
