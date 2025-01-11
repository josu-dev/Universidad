package ar.edu.unlp.info.oo2.ejercicio_7;

import java.time.Duration;
import java.time.LocalDate;

public class StateFinish extends State{

    StateFinish(ToDoItem toDoItem, LocalDate startTime) {
        super(toDoItem);
        this.startTime = startTime;
        this.endTime = LocalDate.now();
    }

    public State start(){
        return this;
    }

    public State togglePause(){
        throw new RuntimeException("El objeto ToDoItem no se encuentra en pause o in-progress");
    }

    public State finish(){
        return this;
    }

    public Duration workedTime(){
        return Duration.between(startTime, endTime);
    }

    @Override
    public Boolean isFinished() {
        return true;
    }
}
