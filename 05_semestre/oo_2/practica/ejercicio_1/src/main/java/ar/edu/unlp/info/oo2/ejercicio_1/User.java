package ar.edu.unlp.info.oo2.ejercicio_1;

import java.util.List;
import java.util.ArrayList;

public class User {
	private List<Tweet> tweets;
	private String screenName;
	
	User(String screenName) {
		this.screenName =screenName;
		this.tweets = new ArrayList<Tweet>();
	}
	
	public boolean isUser(String screenName) {
		return this.screenName.equals(screenName);
	}
	
	public void newTweet(String texto) {
		this.tweets.add(new Tweet(texto, this));
	}
	
	public void newReTweet(Tweet tweet) {
		this.tweets.add(new ReTweet(tweet, this));
	}
	
	public void deleteTweet(Tweet tweet) {
		tweet.deleteTweet();
		this.tweets.remove(tweet);
	}
	
	public void removeTweet(Tweet tweet){
		this.tweets.remove(tweet);
	}
	
	private void deleteTweets() {
		this.tweets.forEach(tweet -> tweet.deleteTweet());
	}
	
	public User deleteUser() {
		this.deleteTweets();
		return this;
	}
}
