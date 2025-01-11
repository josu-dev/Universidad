package ar.edu.unlp.info.oo2.ejercicio_14;

public class PrintTamaño extends PrintProperty {
    public PrintTamaño(FileOO2 file) {
        super(file);
    }

    @Override
    public String prettyPrint() {
        return super.prettyPrint() + " " + this.getTamaño();
    };
}
