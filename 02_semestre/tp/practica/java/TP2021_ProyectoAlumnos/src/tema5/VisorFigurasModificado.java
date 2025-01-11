package tema5;

public class VisorFigurasModificado {
    private int guardadas;
    private Figura [] vector;

    public VisorFigurasModificado(){
        //completar
        guardadas=0;
        vector= new Figura[5];
    }

    public void guardar(Figura f){
        //completar
        vector[guardadas]=f;
        guardadas++;
    }

    public boolean quedaEspacio(){
        //completar
        return guardadas<5;
    }

    public void mostrar(){
        //completar
        for (int i=0;i<guardadas;i++)
            System.out.println(vector[i]);
    }
    
    public int getGuardadas() {
        return guardadas;
    }
}
