package ar.edu.unlp.info.oo1.ejercicio10;

public class JobDescription {
	private String description;
	private double effort;
	private Integer priority;
	
	public JobDescription(double effort, Integer priority, String description) {
		this.effort = effort;
		this.priority = priority;
		this.description = description;
	}
	
	public double effort() {
		return this.effort;
	}
	public String description() {
		return this.description;
	}
	public Integer priority() {
		return this.priority;
	}
}
