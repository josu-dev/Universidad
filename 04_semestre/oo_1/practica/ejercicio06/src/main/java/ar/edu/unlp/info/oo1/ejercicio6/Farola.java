package ar.edu.unlp.info.oo1.ejercicio6;

import java.util.ArrayList;
import java.util.List;

public class Farola {
	
	private boolean state = false;
	private List<Farola> neighbours = new ArrayList<Farola>();
	
	private void addNeighbor(Farola otraFarola) {
		this.neighbours.add(otraFarola);
	}
	
	public void pairWithNeighbor( Farola otraFarola ) {
		this.neighbours.add(otraFarola);
		otraFarola.addNeighbor(this);
	}

	public List<Farola> getNeighbors() {
		return this.neighbours;
	}

	public void turnOn() {
		if (this.isOn()) return;
		this.state = true;
		this.neighbours.forEach(neighbor -> neighbor.turnOn());
	}

	public void turnOff() {
		if (!this.isOn()) return;
		this.state = false;
		this.neighbours.forEach(neighbor -> neighbor.turnOff());
	}

	public boolean isOn() {
		return this.state;
	}
}