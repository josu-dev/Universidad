package ar.edu.unlp.info.oo2.accesobd;

import java.util.Collection;
import java.util.List;

public class DatabaseRealAccessProxy implements DatabaseAccess {
    private boolean isLoggedIn = false;
    private DatabaseRealAccess db;

    public boolean logIn() {
        if (this.isLoggedIn) {
            return false;
        }
        this.isLoggedIn = true;
        this.db = new DatabaseRealAccess();
        return true;
    }

    public boolean logOut() {
        if (!this.isLoggedIn) {
            return false;
        }
        this.isLoggedIn = false;
        return true;
    }

    public int insertNewRow(List<String> rowData) {
        if (!this.isLoggedIn) {
            throw new RuntimeException("Debes iniciar sesion para poder usar la base de datos");
        }
        return this.db.insertNewRow(rowData);
    }

    public Collection<String> getSearchResults(String queryString) {
        if (!this.isLoggedIn) {
            throw new RuntimeException("Debes iniciar sesion para poder usar la base de datos");
        }
        return this.db.getSearchResults(queryString);
    }
}
