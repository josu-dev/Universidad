package ar.edu.unlp.info.oo1.ejercicio10;

import java.util.List;

public interface Strategy {
	public JobDescription extractJob(List<JobDescription> jobs);
}
