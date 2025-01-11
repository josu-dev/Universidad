import jade.core.*;
import jade.core.behaviours.*;
import jade.lang.acl.ACLMessage;
import jade.lang.acl.MessageTemplate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class StateCollector extends BaseAgent {
    private Location originLoc;
    private List<Location> containers = new ArrayList<>();
    private int containerIndex = -1;
    private Location currentContainer;
    private List<SystemInfoReader.SystemInfo> reads = new ArrayList<>();
    private long collectFrequency = 0;
    private AID managerID;
    private boolean isRunning = false;
    private int iterationID = 0;
	private	long iterationStartTick = 0;

    @Override
    protected void setup() {
        originLoc = here();
        classPrintf("setup:\n    name: %s  loc: %s\n", getName(), originLoc.getID());

        Object[] args = getArguments();
        if (args == null || args.length < 2 || !(args[0] instanceof String) || !(args[1] instanceof Boolean)) {
            classPrintf("Expected arguments: <manager-name> <manager-is-localname>\nReceived: %s\n", Arrays.toString(args));
            return;
        }

        managerID = new AID((String) args[0], (boolean) args[1]);
        addBehaviour(new ReceiveUpdatesBehaviour(this));
    }

    @Override
    protected void afterMove() {
        Location currentLoc = here();

        SystemInfoReader.SystemInfo info = SystemInfoReader.getSystemInfo(currentContainer.getID());
        reads.add(info);

        if (currentContainer.getID().equals(originLoc.getID())) {
            long elapsed = System.nanoTime() - iterationStartTick;

            reportStats(elapsed);
            reads.clear();

            scheduleNextCollect();
            // classPrintf("Ended collecting\n");
            return;
        }

        moveToNextContainer();
    }

    private void scheduleNextCollect() {
        addBehaviour(new WakerBehaviour(this, collectFrequency) {
            @Override
            protected void onWake() {
                if (!isRunning) {
                    return;
                }

                // classPrintf("Started collecting\n");
                iterationID++;
                iterationStartTick = System.nanoTime();
                moveToNextContainer();
            }
        });
    }

    private void startCollecting() {
        if (isRunning) {
            return;
        }

        isRunning = true;
        scheduleNextCollect();
    }

    private void moveToNextContainer() {
        int containersSize = containers.size();
        if (containersSize == 0) {
            scheduleNextCollect();
            return;
        }

        if (containersSize == 1 && containers.get(0).equals(here().getID())) {
            classPrintf("moveToNextContainer: Already at origin\n");
            return;
        }
        
        containerIndex = (containerIndex + 1) % containersSize;
        currentContainer = containers.get(containerIndex);

        try {
            doMove(currentContainer);
        } catch (Exception e) {
            classPrintf("Failed to move to %s\n%s: %s\n", currentContainer, e.getClass().getName(), e.getMessage());
            e.printStackTrace();
            if (containers.size() <= 1) {
                doDelete();
                return;
            }

            addBehaviour(new OneShotBehaviour(this) {
                @Override
                public void action() {
                    moveToNextContainer();
                }
            });
        }
    }

    private void reportStats(long elapsed) {
        String header = String.format("Iteration %3d took %.6f s", iterationID, elapsed / 1_000_000_000.0);
        String content = reads.stream()
            .map(SystemInfoReader.SystemInfo::toString)
            .reduce("", (acc, info) -> acc + "\n" + info);
        
        ACLMessage msg = new ACLMessage(ACLMessage.INFORM);
        msg.setContent(header + content);
        msg.addReceiver(managerID);
        
        send(msg);
    }
    
    private class ReceiveUpdatesBehaviour extends CyclicBehaviour {
        public ReceiveUpdatesBehaviour(StateCollector a) {
            super(a);
        }

        @Override
        public void action() {
            MessageTemplate template = MessageTemplate.MatchPerformative(ACLMessage.INFORM);
            ACLMessage msg = receive(template);
            if (msg == null || msg.getPerformative() != ACLMessage.INFORM) {
                if (msg != null) {
                    classPrintf("%s received an unexpected message from %s\n", getName(), msg.getSender().getLocalName());
                }
                block();
                return;
            }

            String content = msg.getContent();
            // classPrintf("%s received a message from %s:\n%s\n", getName(), msg.getSender().getLocalName(), content);
            if (content.equals("STOP")) {
                classPrintf("Agent %s received the stop signal\n", getName());
                classPrintf("Stopping at next collect\n");
                isRunning = false;
                return;
            }

            if (content.startsWith("START")) {
                collectFrequency = Long.parseLong(content.split(" ")[1]);
                // classPrintf("Agent %s received the start signal with frequency %d\n", getName(), collectFrequency);
                // classPrintf("Scheduled next collect\n");
                startCollecting();
                return;
            }

            containers.clear();
            for (String id : content.split(";")) {
                String[] parts = id.split("@");
                String name = parts[0];
                String address = parts[1];
                ContainerID containerID = new ContainerID(name, null);
                containerID.setAddress(address);
                containers.add(containerID);
            }

            // classPrintf("%s received the following containers: %s\n", getName(), containers.stream().map(Location::getID).reduce("", (acc, loc) -> acc + loc + " "));

            if (isRunning) {
                return;
            }
            
            ContainerID thisContainerID = new ContainerID(here().getName(), null);
            for (int i = 0; i < containers.size(); i++) {
                if (containers.get(i).equals(thisContainerID)) {
                    containerIndex = i;
                    currentContainer = containers.get(i);
                    return;
                }
            }
        }
    }
}
