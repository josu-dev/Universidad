package ar.edu.unlp.info.oo1.ejercicio14;

import java.time.LocalDate;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class DateLapseSizedTest {

	DateLapseSized lapsoBase;
	LocalDate inicio, medioSi, medioNo;
	int size;
	
	@BeforeEach
	void setUp() throws Exception {
		inicio= LocalDate.of(2001, 4, 1);
		medioSi= LocalDate.of(2001, 4, 5);
		medioNo= LocalDate.of(2001, 6, 1);
		size= 29;
		lapsoBase = new DateLapseSized(
				inicio,
				size
		);
	}
	
	@Test
	public void testIncludesDate() {
		assertFalse(lapsoBase.includesDate(LocalDate.now()));
		assertTrue(lapsoBase.includesDate(medioSi));
	}
	
	@Test
	public void testSizeInDays() {
		assertEquals(size, lapsoBase.sizeInDays());
	}
	
	@Test
	public void testGetTo() {
		assertEquals(LocalDate.of(2001, 4, 30), lapsoBase.getTo());
	}
}
