
package tema4;

public class Flota {
    private Micro [] micros;
    private int cantidadMicros;
    
    public Flota(){
        micros= new Micro[15];
        cantidadMicros=0;
    }
    
    public boolean getFlotaCompleta(){
        return cantidadMicros==15;
    }
    
    public void setMicro(Micro unMicro){
        micros[cantidadMicros]= unMicro;
        cantidadMicros++;
    }
    
    public boolean getEliminarMicro(String unaPatente){
        int i=0;
        while ((i<cantidadMicros)&&(!micros[i].getPatente().equals(unaPatente)))
            i++;
        if (i<cantidadMicros){
            cantidadMicros--;
            for (i=i;i<(cantidadMicros);i++)
                micros[i]= micros[i+1];
            micros[i]=null;
            return true;
        }
        else
            return false;
    }
    
    public Micro getBuscarMicroPatente(String unaPatente){
        int i=0;
        while ((i<cantidadMicros)&&(!micros[i].getPatente().equals(unaPatente)))
            i++;
        if (i<cantidadMicros)
            return micros[i];
        else
            return null;
    }
    public Micro getBuscarMicroDestino(String unDestino){
        int i=0;
        while ((i<cantidadMicros)&&(!micros[i].getDestino().equals(unDestino)))
            i++;
        if (i<cantidadMicros)
            return micros[i];
        else
            return null;
    }
}
