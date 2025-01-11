package ar.edu.unlp.info.oo2.ejercicio_1;

import java.util.List;
import java.util.ArrayList;

public class Tweet {
	private String text;
	private User user;
	private List<ReTweet> reTweets;
	
	Tweet (String texto, User user) {
		this.text = texto;
		this.user = user;
		this.reTweets = new ArrayList<ReTweet>();
	}
	
	public String getText() {
		return this.text;
	}

	public User getUser() {
		return this.user;
	}
	
	
	public void addReTweet(ReTweet reTweet) {
		this.reTweets.add(reTweet);
	}
	public void removeReTweet(ReTweet reTweet) {
		this.reTweets.remove(reTweet);
	}

	
	public void deleteTweet() {
		this.reTweets.forEach(reTweet -> {
			reTweet.deleteReTweet();
		});
		this.user.removeTweet(this);
	}
}
