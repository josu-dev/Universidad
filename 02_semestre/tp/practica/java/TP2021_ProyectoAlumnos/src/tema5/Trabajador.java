package tema5;

public class Trabajador extends Persona{
    private String tarea;
    
    public Trabajador(){
        super();
    }
    public Trabajador(String suNombre,int suDNI,int suEdad,String suTarea){
        super(suNombre,suDNI,suEdad);
        tarea= suTarea;
    }
    
    public void setTarea(String suTarea){
        tarea= suTarea;
    }
    
    public String getTarea(){
        return tarea;
    }
    
    public String toString(){
        return super.toString()+". Soy "+tarea;
    }
}
