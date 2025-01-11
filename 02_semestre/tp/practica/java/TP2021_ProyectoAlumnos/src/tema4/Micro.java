
package tema4;

public class Micro {
    String patente,destino,horaSalida;
    boolean [] asientos= new boolean[20];
    int asientosOcupados;
    
    public Micro(String unaPatente, String unDestino, String unaHoraSalida){
        patente= unaPatente;
        destino= unDestino;
        horaSalida= unaHoraSalida;
        for (int i=0;i<20;i++)
            asientos[i]=true;
        asientosOcupados=0;
    }
    
    public void setPatente(String unaPatente){
        patente= unaPatente;
    }
    public void setDestino(String unDestino){
        destino= unDestino;
    }
    public void setHoraSalida(String unaHoraSalida){
        horaSalida= unaHoraSalida;
    }
    
    public String getPatente(){
        return patente;
    }
    public String getDestino(){
        return destino;
    }
    public String getHoraSalida(){
        return horaSalida;
    }
    public int getCantAsientosOcupados(){
        return asientosOcupados;
    }
    public boolean getEstaLleno(){
        return asientosOcupados==20;
    }
    public boolean getAsientoEnRango(int unAsiento){
        return (unAsiento>=1)&&(unAsiento<=20);
    }
    public boolean getEstaDisponible(int unAsiento){
        return asientos[unAsiento-1];
    }
    
    public void setOcuparAsiento(int unAsiento){
        asientos[unAsiento-1]=false;
        asientosOcupados++;
    }
    public void setLiberarAsiento(int unAsiento){
        asientos[unAsiento-1]=true;
        asientosOcupados--;
    }
    
    public int getPrimerAsientoLibre(){
        int i=0;
        while (asientos[i]==false)
            i++;
        return (i+1);
    }
}
