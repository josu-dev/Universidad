package ar.edu.unlp.info.oo1.ejercicio16;


import java.time.LocalDate;

public class DateLapse {
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
	
	public boolean overlaps(LocalDate start, LocalDate finish) {
		return !(start.isAfter(this.to) || finish.isBefore(this.from));
	}

	public Integer overlapDays(LocalDate fechaInicio, LocalDate fechaFin) {
		if (!this.overlaps(fechaInicio, fechaFin)) {
			return 0;
		}
		return new DateLapse(
					this.from.isAfter(fechaInicio)	? this.from	: fechaInicio,
					this.to.isBefore(fechaFin)		? this.to	: fechaFin
				).sizeInDays() +1;
	}
}

