package ar.edu.unlp.info.oo2.ejercicio_7;

import java.time.Duration;
import java.time.LocalDate;

public class StateInProgress extends State{

    StateInProgress(ToDoItem toDoItem, LocalDate startTime) {
        super(toDoItem);
        this.startTime = startTime;
    }

    public State start(){
        return this;
    }

    public State togglePause(){
        return new StatePaused(this.toDoItem, this.startTime);
    }

    public State finish(){
        return new StateFinish(this.toDoItem, this.startTime);
    }

    public Duration workedTime(){
        return Duration.between(startTime, LocalDate.now());
    }
}
