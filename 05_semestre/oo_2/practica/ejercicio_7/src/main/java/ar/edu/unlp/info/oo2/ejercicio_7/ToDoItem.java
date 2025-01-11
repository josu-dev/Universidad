package ar.edu.unlp.info.oo2.ejercicio_7;

import java.time.Duration;
import java.util.ArrayList;
import java.util.List;

public class ToDoItem {
    protected State state;
    List<String> comments;

    ToDoItem() {
        this.state = new StatePending(this);
        this.comments = new ArrayList<>();
    }

    ToDoItem(List<String> comments) {
        this.state = new StatePending(this);
        this.comments = comments;
    }

    private void setState(State state) {
        this.state = state;
    }

    public void start() {
        this.setState(this.state.start());
    }

    public void togglePause() {
        this.setState(this.state.togglePause());
    }

    public void finish() {
        this.setState(this.state.finish());
    }

    public Duration workedTime() {
        return this.state.workedTime();
    }

    public void addComment(String comment) {
        if (this.state.isFinished())
            return;

        this.comments.add(comment);
    }
}
