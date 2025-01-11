import jade.core.AID;
import jade.core.ContainerID;
import jade.core.Location;
import jade.core.behaviours.*;
import jade.lang.acl.ACLMessage;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import jade.wrapper.*;


public class Monitor extends BaseAgent {
    private static final String COLLECTOR_NAME = "Collector";
    private static final String COLLECTOR_CLASS = StateCollector.class.getName();
    private static final String COLLECTOR_FREQUENCY = "2000";

    private List<ContainerID> availableContainers = new ArrayList<>();
    private AID collectorID;

    @Override
    protected void setup() {
        classPrintf("setup:\n    name: %s  loc: %s\n", getName(), here().getID());

        AgentController aCollector = null;
        try {
            aCollector = getContainerController().createNewAgent(
                COLLECTOR_NAME,
                COLLECTOR_CLASS,
                new Object[]{this.getClass().getSimpleName(), AID.ISLOCALNAME}
            );
            aCollector.start();
            collectorID = new AID(COLLECTOR_NAME, AID.ISLOCALNAME);
        } catch (Exception e) {
            classPrintf("Unable to create instance of %s, aborting\n%s: %s\n", COLLECTOR_CLASS, e.getClass().getName(), e.getMessage());
            e.printStackTrace();
            if (aCollector != null) {
                try {
                    aCollector.kill();
                } catch (StaleProxyException e1) {
                    // Ignore
                }
            }
            doDelete();
            return;
        }

        addBehaviour(new SendContainersBehaviour(this));
        addBehaviour(new ReceiveReportsBehaviour(this));
        listenToContainers();
        startCollectingStates();
    }

    @Override
	protected void afterMove() {
        throw new AssertionError("This instance isn't supposed to move");
	}

    private void startCollectingStates() {
        addBehaviour(new OneShotBehaviour(this) {
            @Override
            public void action() {
                ACLMessage msg = new ACLMessage(ACLMessage.INFORM);
                msg.setContent("START " + COLLECTOR_FREQUENCY);
                msg.addReceiver(collectorID);
                try {
                    send(msg);
                } catch (Exception e) {
                    classPrintf("Failed to send message to %s\n%s: %s\n", COLLECTOR_NAME, e.getClass().getName(), e.getMessage());
                }
            }
        });
    }

    private void stopCollectingStates() {
        addBehaviour(new OneShotBehaviour(this) {
            @Override
            public void action() {
                ACLMessage msg = new ACLMessage(ACLMessage.INFORM);
                msg.setContent("STOP");
                msg.addReceiver(collectorID);
                send(msg);
            }
        });
    }

    private void listenToContainers() {
        // simple workaround, containers are recived as arguments

        addBehaviour(new OneShotBehaviour(this) {
            @Override
            public void action() {
                ContainerID mainContainer = new ContainerID(CONTAINER_NAME_MAIN, null);
                Location thisLocation = here();
                
                availableContainers.add(mainContainer);
                if (!thisLocation.equals(mainContainer.getID())) {
                    ContainerID thisContainer = new ContainerID(thisLocation.getName(), null);
                    thisContainer.setAddress(thisLocation.getAddress());
                    availableContainers.add(thisContainer);
                }

                String[] args = (String[]) getArguments();
                // classPrintf("args: %s\n", Arrays.toString(args));
                for (int i = 0; i < args.length; i++) {
                    args[i] = args[i].trim();
                }

                for (String arg : args) {
                    String[] parts = arg.split("@");
                    String name = null;
                    String host = null;
                    if (parts.length == 0) {
                        throw new IllegalArgumentException("Invalid container ID: " + arg);
                    }
                    if (parts.length == 1) {
                        name = parts[0];
                    }
                    else {
                        name = parts[0];
                        host = parts[1];
                    }

                    ContainerID container = new ContainerID(name, null);
                    if (host != null) {
                        container.setAddress(host);
                    }

                    boolean found = false;
                    for (ContainerID c : availableContainers) {
                        if (c.equals(container)) {
                            found = true;
                            break;
                        }
                    }

                    if (found) {
                        continue;
                    }
                    availableContainers.add(container);
                }
            }
        });
    }

    private class SendContainersBehaviour extends CyclicBehaviour {
        private int lastLength = 0;
        public SendContainersBehaviour(BaseAgent a) {
            super(a);
        }

        @Override
        public void action() {
            if (availableContainers.size() == lastLength) {
                return;
            }

            lastLength = availableContainers.size();

            ACLMessage msg = new ACLMessage(ACLMessage.INFORM);
            String content = availableContainers.stream().map(Location::getID).reduce("", (acc, container) -> acc + ";" + container).substring(1);
            msg.setContent(content);
            msg.addReceiver(collectorID);
            send(msg);
            // classPrintf("%s sent message to %s: %s\n", getName(), COLLECTOR_NAME, content);
        }
    }

    private class ReceiveReportsBehaviour extends CyclicBehaviour {
        public ReceiveReportsBehaviour(BaseAgent a) {
            super(a);
        }

        @Override
        public void action() {
            ACLMessage metrics = receive();
            if (metrics == null || metrics.getPerformative() != ACLMessage.INFORM || !metrics.getSender().equals(collectorID)) {
                block();
                return;
            }

            // classPrintf("%s received metrics from %s:\n%s\n", getName(), metrics.getSender().getLocalName(), metrics.getContent());
            classPrintf("%s\n", metrics.getContent());
        }
    }
}
