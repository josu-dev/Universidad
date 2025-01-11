package ar.edu.unlp.info.oo2.accesobd;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import java.util.Arrays;
import java.util.Collections;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class DatabaseRealAccessProxyTest {
    private DatabaseAccess databaseLogged;
    private DatabaseAccess databaseNoLogged;

    @BeforeEach
    void setUp() throws Exception {
        this.databaseLogged = new DatabaseRealAccessProxy();
        ((DatabaseRealAccessProxy)this.databaseLogged).logIn();
        this.databaseNoLogged = new DatabaseRealAccessProxy();
    }

    @Test
    void testGetSearchResults() {
        assertThrows(RuntimeException.class, () -> this.databaseNoLogged.getSearchResults("select * from comics where id=10"));
        assertEquals(Arrays.asList("Spiderman", "Marvel"), this.databaseLogged.getSearchResults("select * from comics where id=1"));
        assertEquals(Collections.emptyList(), this.databaseLogged.getSearchResults("select * from comics where id=10"));
    }

    @Test
    void testInsertNewRow() {
        assertThrows(RuntimeException.class, () -> this.databaseNoLogged.insertNewRow(Arrays.asList("Patoruzú", "La flor")));
        assertEquals(3, this.databaseLogged.insertNewRow(Arrays.asList("Patoruzú", "La flor")));
        assertEquals(Arrays.asList("Patoruzú", "La flor"), this.databaseLogged.getSearchResults("select * from comics where id=3"));
    }
}
