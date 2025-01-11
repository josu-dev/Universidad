package ar.edu.unlp.info.oo2.ejercicio_7;

import java.time.Duration;
import java.time.LocalDate;

public class StatePending extends State{

    StatePending(ToDoItem toDoItem) {
        super(toDoItem);
    }

    public State start(){
        return new StateInProgress(this.toDoItem, LocalDate.now());
    }

    public State togglePause(){
        throw new RuntimeException("El objeto ToDoItem no se encuentra en pause o in-progress");
    }

    public State finish(){
        return this;
    }

    public Duration workedTime(){
        throw new RuntimeException("El objeto ToDoItem no se ha iniciado, no existe tiempo trabajado");
    }
}
