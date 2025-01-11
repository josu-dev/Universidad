package ar.edu.unlp.info.oo2.ejercicio_5;

import java.time.LocalDate;
import java.util.Date;

public class FileSystem {
    private Directory root;

    FileSystem(){
        this.root = new Directory("root", LocalDate.now());
    }    
}
