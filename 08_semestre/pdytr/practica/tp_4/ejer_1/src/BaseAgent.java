import jade.core.Agent;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

public class BaseAgent extends Agent {
    protected static final String CONTAINER_NAME_MAIN = "Main-Container";
    private static final DateTimeFormatter TIME_FORMATTER = DateTimeFormatter.ofPattern("HH:mm:ss");

    protected void classPrintf(String message, Object... args) {
        String timeStamp = LocalTime.now().format(TIME_FORMATTER);
        String format = "[" + timeStamp + " " + getClass().getName() + "] " + message;
        System.out.print(String.format(format, args));
    }
    
    @Override
    protected void takeDown() {
        classPrintf("%s is shutting down\n", getName());
    }
}
