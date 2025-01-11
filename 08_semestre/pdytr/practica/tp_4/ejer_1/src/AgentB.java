public class AgentB extends BaseAgent {
    @Override
	protected void setup() {
        classPrintf("setup:\n    name: %s  loc: %s\n", getName(), here().getID());
	}

    @Override
	protected void afterMove() {
        classPrintf("afterMove:\n    name: %s  loc: %s\n", getName(), here().getID());
	}
}
