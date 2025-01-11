package ar.edu.unlp.info.oo1.ejercicio14;

import java.time.LocalDate;

public class DateLapse implements IntDateLapse{
	private LocalDate from, to;
	
	public DateLapse(LocalDate from, LocalDate to) {
		this.from = from;
		this.to = to;
	}
	
	public LocalDate getFrom() {
		return this.from;
	}

	public LocalDate getTo() {
		return this.to;
	}
	
	public int sizeInDays() {
		return this.from.until(this.to).getDays();
	}
	public boolean includesDate(LocalDate other) {
		return this.from.isBefore(other) && this.to.isAfter(other);
	}
}
