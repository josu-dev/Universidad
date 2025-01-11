package ar.edu.unlp.info.oo2.ejercicio_4;

public class Planeta {
    Topografia topografia;

    Planeta(Topografia topografia) {
        this.topografia = topografia;
    }

    public Double calcularProporcionAgua() {
        return this.topografia.getProporcionAgua();
    }
}
