package ar.edu.unlp.info.oo1.ejercicio10;

import java.util.List;

public class MostEffortStrategy implements Strategy {

	@Override
	public JobDescription extractJob(List<JobDescription> jobs) {
		JobDescription nextJob = jobs
				.stream()
				.max((job1, job2) -> (int)(job1.effort() - job2.effort()))
				.orElseGet(() -> null);
		if (nextJob != null) jobs.remove(nextJob);
		return nextJob;
	}
}
