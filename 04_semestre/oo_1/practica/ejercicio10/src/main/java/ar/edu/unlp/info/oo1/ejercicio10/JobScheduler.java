package ar.edu.unlp.info.oo1.ejercicio10;

import java.util.ArrayList;
import java.util.List;

public class JobScheduler {
	private List<JobDescription> jobs;
	private Strategy strategy;
	
	public JobScheduler() {
		this.jobs = new ArrayList<JobDescription>();
	}
	
	public List<JobDescription> getJobs() {
		return this.jobs;
	}
	
	public void setStrategy(Strategy strategy) {
		this.strategy = strategy;
	}
	public void schedule(JobDescription job) {
		this.jobs.add(job);
	}
	public void unschedule(JobDescription job) {
		this.jobs.remove(job);
	}
	public JobDescription next() {
		return this.strategy.extractJob(jobs);
	}
}
