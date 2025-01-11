package ar.edu.unlp.info.oo1.ejercicio9;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class CajaDeAhorroTest {

	CajaDeAhorro sinFondos, conFondos, conPocosFondos;
	@BeforeEach
	void setUp() throws Exception {
		sinFondos = new CajaDeAhorro();
		conFondos = new CajaDeAhorro();
		conFondos.depositar(10000);
		conPocosFondos = new CajaDeAhorro();
		conPocosFondos.depositar(100);
	}
	
    @Test
    public void testPuedeExtraer() {
        assertFalse(sinFondos.extraer(10));
        assertTrue(conFondos.extraer(1000));
        assertFalse(conPocosFondos.extraer(100));
    }
    
    @Test
    public void testTransferirACuenta() {
        assertFalse(sinFondos.transferirACuenta(10, conFondos));
        assertTrue(conFondos.transferirACuenta(100, sinFondos));
        assertTrue(conPocosFondos.transferirACuenta(90, sinFondos));
    }
}
