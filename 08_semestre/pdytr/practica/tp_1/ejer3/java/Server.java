/*
 * Server.java
 * Just receives some data and sends back a "message" to a client
 *
 * Usage:
 * java Server port
 */
import java.io.*;
import java.net.*;

import java.util.Arrays;

import java.security.*;


public class Server {
    public static void main(String[] args) throws IOException {
        if ((args.length != 3) || (Integer.valueOf(args[0]) <= 0) || (Integer.valueOf(args[1]) <= 0) || (Integer.valueOf(args[2]) <= 0)) {
            System.out.println("3 arguments needed: port exponent iteration");
            System.exit(1);
        }

        long[] clientHashTable = {
            Long.parseUnsignedLong("5675108439014857236"),
            Long.parseUnsignedLong("3471083743766332941"),
            Long.parseUnsignedLong("10399782840589422850"),
            Long.parseUnsignedLong("339580640052000121"),
            Long.parseUnsignedLong("9338733507955096752"),
            Long.parseUnsignedLong("14737036014299662981"),
            Long.parseUnsignedLong("10460870566151307044"),
        };

        int exponent = Integer.valueOf(args[1]);
        int iteration = Integer.valueOf(args[2]);
        int bufferSize = (int)Math.pow(10, exponent);
        byte[] sendBuffer = Utils.setupBuffer(12, new byte[bufferSize]);
        byte[] readBuffer = new byte[bufferSize];
        Arrays.fill(readBuffer, 0, bufferSize, "\0".getBytes()[0]);

        ServerSocket serverSocket = null;
        try {
            serverSocket = new ServerSocket(Integer.valueOf(args[0]));
        } catch (Exception e) {
            System.out.println("Error on server socket");
            System.exit(1);
        }

        // serverSocket.setOption(StandardSocketOptions.TCP_NODELAY, true);

        Socket connected_socket = null;
        try {
            connected_socket = serverSocket.accept();
        } catch (IOException e) {
            System.err.println("Error on Accept");
            System.exit(1);
        }

        /* Get the I/O streams from the connected socket */
        DataInputStream fromclient = new DataInputStream(connected_socket.getInputStream());
        DataOutputStream toclient = new DataOutputStream(connected_socket.getOutputStream());

        byte[] readBuff = new byte[bufferSize];
        int readBytes = 0, n, readIterations = 0;
        while (readBytes < bufferSize) {
            readIterations++;
            n = fromclient.read(readBuffer, readBytes, bufferSize - readBytes);
            if ( n < 0 ) {
                System.err.println("Error to read readBuffer");
                System.exit(1);
            }

            readBytes += n;
        }

        toclient.write(sendBuffer, 0, bufferSize);

        byte[] ack = new byte[1];
        fromclient.read(ack, 0, 1);

        fromclient.close();
        toclient.close();
        connected_socket.close();
        serverSocket.close();

        boolean readIntegrity = readBytes == bufferSize && Utils.isSdbm(readBuffer, clientHashTable[exponent -1]);

        System.out.print(String.format(
            "%s,%s,%s,%s,%s,0\n",
            iteration,
            bufferSize,
            readBytes,
            readIterations,
            readIntegrity ? "true" : "false"
        ));
    }
}
