import jade.core.*;

public class AgentB extends BaseAgent {
    private Location originLoc;

    @Override
	protected void setup() {
        originLoc = here();
        classPrintf("setup:\n    name: %s  loc: %s\n", getName(), originLoc.getID());
	}

    @Override
	protected void afterMove() {
        Location currentLoc = here();
        classPrintf("afterMove:\n    name: %s  loc: %s\n", getName(), currentLoc.getID());

        if (currentLoc.getID().equals(originLoc.getID())) {
            classPrintf("Agent %s has returned to its origin\n", getName());
            return;
        }

        doWait(2 * 1000);

        try {
            classPrintf("Attempting to move back to %s\n", originLoc.getID());
            doMove(originLoc);
        }
        catch (Exception e) {
            classPrintf("Failed to move back to %s\n%s: %s\n", originLoc.getID(), e.getClass().getName(), e.getMessage());
            doDelete();
        }
	}
}
