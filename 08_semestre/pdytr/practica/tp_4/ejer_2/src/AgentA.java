import jade.core.ContainerID;
import jade.wrapper.*;

public class AgentA extends BaseAgent {
    @Override
	protected void setup() {
        classPrintf("setup:\n    name: %s  loc: %s\n", getName(), here().getID());

        AgentContainer ac = getContainerController();
		AgentController cAgentB;
        try {
			cAgentB = ac.createNewAgent("AgenteB", "AgenteB", null);
		} catch (IllegalStateException | ControllerException e) {
			classPrintf("Unable to create instance of AgenteB, aborting\n%s: %s\n", e.getClass().getName(), e.getMessage());
            doDelete();
            return;
        }

        ContainerID agentBDest = new ContainerID(CONTAINER_NAME_MAIN, null);
        try {
            cAgentB.start();

            classPrintf("Migrating agent %s to %s\n", cAgentB.getName(), agentBDest.getID());
            cAgentB.move(agentBDest);
            classPrintf("Migrated agent %s to %s\n", cAgentB.getName(), agentBDest.getID());
        } catch (StaleProxyException e) {
            classPrintf("Migration failed, aborting\n%s: %s\n", e.getClass().getName(), e.getMessage());
            doDelete();
            return;
        }
	}

    @Override
	protected void afterMove() {
        throw new AssertionError("This instance of AgenteA should never be migrated");
	}
}
