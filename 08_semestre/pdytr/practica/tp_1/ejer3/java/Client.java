/*
 * Client.java
 * Just sends stdin read data to and receives back some data from the server
 *
 * usage:
 * java Client serverhostname port exponent iteration
 */
import java.io.*;
import java.net.*;

import java.util.Arrays;
import java.security.*;

import java.lang.Math;

public class Client {
    public static void main(String[] args) throws IOException {
        if ((args.length != 4) || (Integer.valueOf(args[1]) <= 0) || (Integer.valueOf(args[2]) <= 0) || (Integer.valueOf(args[3]) <= 0)) {
            System.out.println("5 arguments needed: host port exponent iteration");
            System.exit(1);
        }

        long[] serverHashTable = {
            Long.parseUnsignedLong("4970794450630634548"),
            Long.parseUnsignedLong("3686246933712568826"),
            Long.parseUnsignedLong("17644093870996294051"),
            Long.parseUnsignedLong("3931224720788180482"),
            Long.parseUnsignedLong("8316741297499231479"),
            Long.parseUnsignedLong("6984026108103235308"),
            Long.parseUnsignedLong("17813027598986875140"),
        };

        int exponent = Integer.valueOf(args[2]);
        int iteration = Integer.valueOf(args[3]);
        int bufferSize = (int)Math.pow(10, exponent);
        byte[] sendBuffer = Utils.setupBuffer(0, new byte[bufferSize]);
        byte[] readBuffer = new byte[bufferSize];
        Arrays.fill(readBuffer, 0, bufferSize, "\0".getBytes()[0]);

        Socket socketwithserver = null;
        try {
            socketwithserver = new Socket(args[0], Integer.valueOf(args[1]));
        } catch (Exception e) {
            System.out.println("ERROR connecting");
            System.out.println(e);
            System.exit(1);
        }

        socketwithserver.setOption(StandardSocketOptions.TCP_NODELAY, true);

        /* Streams for I/O through the connected socket */
        DataInputStream fromserver = new DataInputStream(socketwithserver.getInputStream());
        DataOutputStream toserver = new DataOutputStream(socketwithserver.getOutputStream());
        
        long tick = System.nanoTime();

        toserver.write(sendBuffer, 0, bufferSize);  

        byte[] readBuff = new byte[bufferSize];
        int readBytes = 0, n, readIterations = 0;
        while (readBytes < bufferSize) {
            readIterations++;
            n = fromserver.read(readBuffer, readBytes, bufferSize - readBytes);
            if ( n < 0 ) {
                System.err.println("Error to read readBuffer");
                System.exit(1);
            }

            readBytes += n;
        }

        long elapsed = System.nanoTime() - tick;

        byte[] ack = new byte[1];
        ack[0] = 1;
        toserver.write(ack, 0, 1);

        fromserver.close();
        toserver.close();
        socketwithserver.close();

        boolean readIntegrity = readBytes == bufferSize && Utils.isSdbm(readBuffer, serverHashTable[exponent-1]);

        System.out.print(String.format(
            "%s,%s,%s,%s,%s,%.6f\n",
            iteration,
            bufferSize,
            readBytes,
            readIterations,
            readIntegrity ? "true" : "false",
            elapsed / 1_000_000_000.0
        ));
    }
}
