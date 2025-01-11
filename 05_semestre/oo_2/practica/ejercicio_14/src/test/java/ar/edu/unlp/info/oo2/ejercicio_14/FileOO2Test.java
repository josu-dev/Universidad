package ar.edu.unlp.info.oo2.ejercicio_14;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.Date;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class FileOO2Test {
    FileOO2 file;
    FileOO2 nombre;
    FileOO2 extension;
    FileOO2 tamaño;

    @BeforeEach
    public void setup() throws Exception {
        file = new File("test", ".txt", 0, new Date(), new Date(), "rwx-rwx-rwx");
        nombre = new PrintName(file);
        extension= new PrintExtension(file);
        tamaño= new PrintTamaño(file);
    }

    @Test
    public void nombreExtensionTest() {
        extension = new PrintExtension(nombre);
        assertEquals("Datos del archivo: test .txt", extension.prettyPrint());
    }
    
    @Test
    public void tamañoExtensionNombreTest() {
        extension = new PrintExtension(tamaño);
        nombre = new PrintName(extension);
        assertEquals("Datos del archivo: 0 .txt test", nombre.prettyPrint());
    }
}
