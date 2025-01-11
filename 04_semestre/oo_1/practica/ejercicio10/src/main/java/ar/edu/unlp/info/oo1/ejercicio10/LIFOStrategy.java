package ar.edu.unlp.info.oo1.ejercicio10;

import java.util.List;

public class LIFOStrategy implements Strategy {

	@Override
	public JobDescription extractJob(List<JobDescription> jobs) {
		return jobs.isEmpty()? null :jobs.remove(jobs.size() -1);
	}
}
