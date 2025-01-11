package ar.edu.unlp.info.oo1.ejercicio10;

import java.util.List;

public class HighestPriorityStrategy implements Strategy {

	@Override
	public JobDescription extractJob(List<JobDescription> jobs) {
		JobDescription nextJob = jobs
				.stream()
				.max((job1, job2) -> job1.priority() - job2.priority())
				.orElseGet(() -> null);
		if (nextJob != null) jobs.remove(nextJob);
		return nextJob;
	}
}
