package ar.edu.unlp.info.oo1.ejercicio14;

import java.time.LocalDate;

public class DateLapseSized implements IntDateLapse{
	private LocalDate from;
	private int sizeInDays;
	
	public DateLapseSized(LocalDate from, int sizeInDays) {
		this.from = from;
		this.sizeInDays = sizeInDays;
	}
	
	public LocalDate getFrom() {
		return this.from;
	}

	public LocalDate getTo() {
		return this.from.plusDays(sizeInDays);
	}
	
	public int sizeInDays() {
		return this.sizeInDays;
	}
	public boolean includesDate(LocalDate other) {
		return this.from.isBefore(other) && this.getTo().isAfter(other);
	}
}
