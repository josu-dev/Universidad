package ar.edu.unlp.info.oo2.ejercicio_3;

public class VideoStreamAdapter extends Media {
    private VideoStream videoStream;

    VideoStreamAdapter() {
        this.videoStream = new VideoStream();
    }

    public void play() {
        this.videoStream.reproduce();
    }
}
