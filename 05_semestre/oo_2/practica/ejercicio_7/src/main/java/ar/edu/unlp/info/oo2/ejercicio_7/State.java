package ar.edu.unlp.info.oo2.ejercicio_7;

import java.time.Duration;
import java.time.LocalDate;

abstract public class State {
    protected ToDoItem toDoItem;
    protected LocalDate startTime;
    protected LocalDate endTime;

    State(ToDoItem toDoItem) {
        this.toDoItem = toDoItem;
    }

    abstract public State start();

    abstract public State togglePause();

    abstract public State finish();

    abstract public Duration workedTime();

    public Boolean isFinished() {
        return false;
    }
}
