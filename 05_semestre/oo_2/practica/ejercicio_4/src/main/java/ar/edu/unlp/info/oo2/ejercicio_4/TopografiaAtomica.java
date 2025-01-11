package ar.edu.unlp.info.oo2.ejercicio_4;

public abstract class TopografiaAtomica extends Topografia {

    public Boolean equals(Topografia topografia) {
        if (!(topografia instanceof TopografiaAtomica) || topografia == null) {
            return false;
        }
        return topografia.getProporcionAgua() == this.getProporcionAgua();
    };
}
