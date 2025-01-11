package tema5;

public class Jugador extends Empleado{
    private int partidosJugados, golesAnotados;
    
    public Jugador(){
        super();
    }
    public Jugador(String unNombre,double unSueldo,int cantPartidos,int cantGoles){
        super(unNombre,unSueldo);
        partidosJugados= cantPartidos;
        golesAnotados= cantGoles;
    }
    
    public void setPartidosJugados(int cantPartidos){
        partidosJugados= cantPartidos;
    }
    public void setGolesAnotados(int cantGoles){
        golesAnotados= cantGoles;
    }
    
    public int getPartidosJugados(){
        return partidosJugados;
    }
    public int getGolesAnotados(){
        return golesAnotados;
    }
    
    public double calcularSueldoACobrar(){
        double aux;
        if ((double)golesAnotados/partidosJugados>0.5)
            aux= getSueldoBase()*2;
        else
            aux= getSueldoBase();
        return aux;
    }
}
