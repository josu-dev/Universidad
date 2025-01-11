package ar.edu.unlp.info.oo2.ejercicio_1;

import java.util.Map;
import java.util.HashMap;

public class Twitter {
	private Map<String, User> users;
	
	Twitter() {
		this.users = new HashMap<String, User>();
	}
	
	public User newUser(String screenName) {
		if (this.users.containsKey(screenName)) {
			return null;
		}
		User newUser = new User(screenName);
		this.users.put(screenName, newUser);
		return newUser;
	}
	
	public User deleteUser(String screenName) {
		User userToDelete = this.users.remove(screenName);
		if (userToDelete == null) {
			return null;
		}
		userToDelete.deleteUser();
		return userToDelete;
	}
}
