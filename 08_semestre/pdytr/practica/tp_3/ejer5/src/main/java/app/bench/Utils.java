package app.bench;

import java.util.Random;
import java.nio.charset.StandardCharsets;

public class Utils {
    public static long sdbm(byte[] data) {
        long hash = 0;

        for (byte c : data) {
            hash = c + ((hash << 6) + (hash << 16) - hash);
        }

        return hash;
    }

    public static boolean isSdbm(byte[] data, long hash) {
        return sdbm(data) == hash;
    }

    public static byte[] setupBuffer(int seed, int length) {
        Random random = new Random(seed);
        byte[] buffer = new byte[length];
        random.nextBytes(buffer);
        return buffer;
    }

    public static void precomputeSdbms(int seed, int start, int end){
        for (int i = start; i <= end; i++) {
            byte[] buffer = setupBuffer(seed, (int)Math.pow(10, i));
            System.out.println("sdbm(" + i + ") = " + unsignedToString(sdbm(buffer)));
        }
    }

    // from stackoverflow
    public static String unsignedToString(long n) {
        long temp = (n >>> 1) / 5;
        return String.format("%019d", temp) + (n - temp * 10);
    }
}
