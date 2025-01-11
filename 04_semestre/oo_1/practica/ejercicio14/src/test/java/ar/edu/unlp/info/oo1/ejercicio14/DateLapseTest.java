package ar.edu.unlp.info.oo1.ejercicio14;

import java.time.LocalDate;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class DateLapseTest {

	DateLapse lapsoBase;
	LocalDate inicio, fin, medioSi, medioNo;
	
	@BeforeEach
	void setUp() throws Exception {
		inicio= LocalDate.of(2001, 4, 1);
		fin= LocalDate.of(2001, 4, 30);
		medioSi= LocalDate.of(2001, 4, 5);
		medioNo= LocalDate.of(2001, 6, 1);
		lapsoBase = new DateLapse(
				inicio,
				fin
		);
	}
	
	@Test
	public void testIncludesDate() {
		assertFalse(lapsoBase.includesDate(LocalDate.now()));
		assertTrue(lapsoBase.includesDate(medioSi));
	}
	
	@Test
	public void testSizeInDays() {
		assertEquals(29, lapsoBase.sizeInDays());
	}
	
	@Test
	public void testGetTo() {
		assertEquals(LocalDate.of(2001, 4, 30), lapsoBase.getTo());
	}
}
