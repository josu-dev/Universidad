
package tema4;


public class Autor {
    private String nombre,biografia;
    
    public Autor(){
        
    }
    public Autor(String nombreLeido, String biografiaLeida){
        nombre= nombreLeido;
        biografia= biografiaLeida;
    }
    
    public void setNombre(String nombreLeido){
        nombre= nombreLeido;
    }
    public void setBiografia(String biografiaLeida){
        biografia= biografiaLeida;
    }
    
    public String getNombre(){
        return nombre;
    }
    public String getBiografia(){
        return biografia;
    }
    
}
