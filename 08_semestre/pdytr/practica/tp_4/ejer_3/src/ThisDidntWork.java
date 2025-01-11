import jade.core.AID;
import jade.core.ContainerID;
import jade.core.Location;
import jade.core.behaviours.*;
import jade.lang.acl.ACLMessage;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import jade.wrapper.*;


public class ThisDidntWork extends BaseAgent {
    private static final String COLLECTOR_NAME = "Collector";
    private static final String COLLECTOR_CLASS = "InfoCollector";
    private static final String COLLECTOR_FREQUENCY = "2000";

    private List<ContainerID> availableContainers = new ArrayList<>();

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
        addBehaviour(new ReceiveMetricsBehaviour(this));
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
                msg.addReceiver(new AID(COLLECTOR_NAME, AID.ISLOCALNAME));
                try {
                    send(msg);
                } catch (Exception e) {
                    classPrintf("Failed to send message to %s\n%s: %s\n", COLLECTOR_NAME, e.getClass().getName(), e.getMessage());
                }
            }
        });
    }

    private void stopCollectingStates() {
        // if (!isRunning) {
        //     return;
        // }
        addBehaviour(new OneShotBehaviour(this) {
            @Override
            public void action() {
                // if (!isRunning) {
                //     return;
                // }
                // isRunning = false;
                ACLMessage msg = new ACLMessage(ACLMessage.INFORM);
                msg.setContent("STOP");
                msg.addReceiver(new AID(COLLECTOR_NAME, AID.ISLOCALNAME));
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
                classPrintf("args: %s\n", Arrays.toString(args));
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
            msg.addReceiver(new AID(COLLECTOR_NAME, AID.ISLOCALNAME));
            send(msg);
            classPrintf("Agent %s sent message to %s: %s\n", getName(), COLLECTOR_NAME, content);
        }
    }

    private class ReceiveMetricsBehaviour extends CyclicBehaviour {
        public ReceiveMetricsBehaviour(BaseAgent a) {
            super(a);
        }

        @Override
        public void action() {
            ACLMessage metrics = receive();
            if (metrics == null || metrics.getPerformative() != ACLMessage.INFORM || !metrics.getSender().getLocalName().equals(COLLECTOR_NAME)) {
                block();
                return;
            }

            classPrintf("Agent %s received metrics from %s:\n%s\n", getName(), metrics.getSender().getLocalName(), metrics.getContent());
        }
    }

    
    // This should work but it doesn't recive any event from the AMS
    // after the initial state when its created
	// private AMSSubscriber containerAMSListener;
    // containerAMSListener = new ContainersListenerBehaviour();
    // addBehaviour(containerAMSListener);
    // private void listenToContainers() {
    //     containerAMSListener = new ContainersListenerBehaviour();
    //     addBehaviour(containerAMSListener);
        
    //     classPrintf("enter listten containers: %d\n",availableContainers.size());
    //     addBehaviour(new TickerBehaviour(this, 5 * 1000) {
    //         @Override
    //         protected void onTick() {
    //             classPrintf("tick containers: %d\n",availableContainers.size());
    //             if (containerAMSListener != null) {
    //                 send(containerAMSListener.getCancel());
    //                 removeBehaviour(containerAMSListener);
    //                 classPrintf("CANCELLED container listener\n");
    //             }
    //             containerAMSListener = new ContainersListenerBehaviour();
    //             addBehaviour(containerAMSListener);
    //             classPrintf("ADDED container listener\n");
    //         }
    //     });
    //     getContentManager().registerLanguage(new SLCodec(), FIPANames.ContentLanguage.FIPA_SL0);
    //     getContentManager().registerOntology(MobilityOntology.getInstance());
    //     addBehaviour(new GetAvailableLocationsBehaviour(Monitor.this));
    // }
    
    // @Override
    // protected void takeDown() {
    //     super.takeDown();
    //     if (containerAMSListener != null) {
    //         send(containerAMSListener.getCancel());
    //     }
    // }

    // private class ContainersListenerBehaviour extends AMSSubscriber {
    //     @Override
    //     @SuppressWarnings("unchecked")
    //     protected void installHandlers(Map handlers){
    //         EventHandler addedHandler = new EventHandler(){
    //             public void handle(Event event){
    //                 ContainerID container = ((AddedContainer) event).getContainer();
    //                 classPrintf("EVENT ADDED container: %s\n", container.getName());
    //                 for (ContainerID c : availableContainers) {
    //                     if (c.getID().equals(container.getID())) {
    //                         return;
    //                     }
    //                 }
    //                 availableContainers.add(container);
    //                 classPrintf("ADDED container: %s (%d)\n", container.getName(),availableContainers.size());
    //                 // classPrintf("containers: " + availableContainers.stream().map(Location::getName).reduce("", (acc, c) -> acc + " " + c).trim());
                
    //             }
    //         };

    //         EventHandler removedHandler = new EventHandler(){
    //             public void handle(Event event){
    //                 Location removedContainer = ((RemovedContainer) event).getContainer();
    //                 classPrintf("EVENT REMOVED container: %s\n", removedContainer.getName());
    //                 for (int i = 0; i < availableContainers.size(); i++) {
    //                     if (availableContainers.get(i).getID().equals(removedContainer.getID())) {
    //                         availableContainers.remove(i);
    //                         classPrintf("REMOVED container: %s (%d)\n", removedContainer.getName(),availableContainers.size());
    //                         return;
    //                     }
    //                 }
    //                 // ArrayList<ContainerID> temp = new ArrayList<ContainerID>(availableContainers);
    //                 // for(ContainerID container : temp){
    //                 //     if(container.getID().equalsIgnoreCase(removedContainer.getContainer().getID()))
    //                 //         availableContainers.remove(container);
    //                 // }
    //             }
    //         };

    //         handlers.put(IntrospectionVocabulary.ADDEDCONTAINER, addedHandler);
    //         handlers.put(IntrospectionVocabulary.REMOVEDCONTAINER, removedHandler);
    //         handlers.put(IntrospectionVocabulary.BORNAGENT, new EventHandler() {
    //             public void handle(Event event) {
    //                 classPrintf("EVENT BORN agent: %s\n", ((BornAgent) event).getAgent().getName());
    //             }
    //         });
    //         handlers.put(IntrospectionVocabulary.ADDEDCONTAINER, new EventHandler() {
    //             public void handle(Event event) {
    //                 classPrintf("EVENT ADDED CONTAINER agent: %s\n", ((AddedContainer) event).getContainer().getName());
    //             }
    //         });
    //         handlers.put(IntrospectionVocabulary.REMOVEDCONTAINER, new EventHandler() {
    //             public void handle(Event event) {
    //                 classPrintf("EVENT REMOVED CONTAINER agent: %s\n", ((RemovedContainer) event).getContainer().getName());
    //             }
    //         });
    //     }
    // }
    
    // https://gitlab.com/jade-project/jade/-/blob/master/src/main/java/examples/mobile/MobileAgent.java?ref_type=heads
    // public class GetAvailableLocationsBehaviour extends SimpleAchieveREInitiator {
    //     private ACLMessage request;
        
    //     public GetAvailableLocationsBehaviour(Monitor a) {
    //         super(a, new ACLMessage(ACLMessage.REQUEST));
    //         request = (ACLMessage)getDataStore().get(REQUEST_KEY);
    //         // fills all parameters of the request ACLMessage
    //         request.clearAllReceiver();
    //         request.addReceiver(a.getAMS());
    //         request.setLanguage(FIPANames.ContentLanguage.FIPA_SL0);
    //         request.setOntology(MobilityOntology.NAME);
    //         request.setProtocol(FIPANames.InteractionProtocol.FIPA_REQUEST);
    //         // creates the content of the ACLMessage
    //         try {
    //             Action action = new Action();
    //             action.setActor(a.getAMS());
    //             action.setAction(new QueryPlatformLocationsAction());
    //             a.getContentManager().fillContent(request, action);
    //             send(request);
    //         }
    //         catch(Exception fe) {
    //             fe.printStackTrace();

    //         }
    //         reset(request);
    //     }
    
    //     protected void handleOutOfSequence(ACLMessage inform) {
    //         String content = inform.getContent();
    //         try {
    //             Result results = (Result)myAgent.getContentManager().extractContent(inform);
    //             for (jade.util.leap.Iterator it = results.getItems().iterator(); it.hasNext(); ) {
    //                 Location loc = (Location)it.next();
    //             }
    //             // for (Location loc : results.getItems().iterator()) {
    //             // }
    //             // ((MobileAgent)myAgent).gui.updateLocations(results.getItems().iterator());
    //         }
    //         catch(Exception e) {
    //             e.printStackTrace();
    //         }
    //         System.out.flush();
    //     }
    //     protected void handleInform(ACLMessage inform) {
    //         String content = inform.getContent();
    //         try {
    //             Result results = (Result)myAgent.getContentManager().extractContent(inform);
    //             for (jade.util.leap.Iterator it = results.getItems().iterator(); it.hasNext(); ) {
    //                 Location loc = (Location)it.next();
    //             }
    //             // for (Location loc : results.getItems().iterator()) {
    //             // ((MobileAgent)myAgent).gui.updateLocations(results.getItems().iterator());
    //         }
    //         catch(Exception e) {
    //             e.printStackTrace();
    //         }
    //     }
        
    //     protected void handleNotUnderstood(ACLMessage reply) {
    //     }

    //     protected void handleRefuse(ACLMessage reply) {
    //     }

    //     protected void handleFailure(ACLMessage reply) {
    //     }

    //     protected void handleAgree(ACLMessage reply) {
    //     }
    // }
}
