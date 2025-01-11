package ar.edu.unlp.info.oo2.ejercicio_1;

public class ReTweet extends Tweet{
	private Tweet baseTweet;
	private User user;
	
	ReTweet(Tweet tweet, User user) {
		super(tweet.getText(), tweet.getUser());
		this.baseTweet = tweet;
		this.user = user;
		tweet.addReTweet(this);
	}
	
	public User getUser() {
		return this.user;
	}
	

	public void deleteReTweet() {
		this.baseTweet.removeReTweet(this);
		this.deleteTweet();
	}
}
