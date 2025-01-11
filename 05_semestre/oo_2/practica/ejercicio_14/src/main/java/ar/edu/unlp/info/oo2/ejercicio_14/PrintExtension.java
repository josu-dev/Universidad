package ar.edu.unlp.info.oo2.ejercicio_14;

public class PrintExtension extends PrintProperty {
    public PrintExtension(FileOO2 file) {
        super(file);
    }

    @Override
    public String prettyPrint() {
        return super.prettyPrint() + " " + this.getExtension();
    };
}
