package ar.edu.unlp.info.oo2.ejercicio_14;

public class PrintName extends PrintProperty {
    public PrintName(FileOO2 file) {
        super(file);
    }

    @Override
    public String prettyPrint() {
        return super.prettyPrint() + " " + this.getNombre();
    };
}
