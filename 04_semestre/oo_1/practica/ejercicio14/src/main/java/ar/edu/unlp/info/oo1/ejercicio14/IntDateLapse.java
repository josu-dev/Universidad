package ar.edu.unlp.info.oo1.ejercicio14;

import java.time.LocalDate;

public interface IntDateLapse {
	public LocalDate getFrom();
	public LocalDate getTo();
	public int sizeInDays();
	public boolean includesDate(LocalDate other);
}
