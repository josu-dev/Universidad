import java.util.Random;
import java.lang.*;

public class Utils {
    public static long sdbm(byte[] data) {
        long hash = 0;

        for (byte b : data) {
            hash = b + ((hash << 6) + (hash << 16) - hash);
        }

        return hash;
    }

    public static boolean isSdbm(byte[] data, long hash) {
        return sdbm(data) == hash;
    }

    public static byte[] setupBuffer(int seed, byte[] buffer) {
        Random random = new Random(seed);
        random.nextBytes(buffer);
        return buffer;
    }

    public static void precomputeSdbms(int seed, int start, int end){
        for (int i = start; i <= end; i++) {
            byte[] buffer = setupBuffer(seed, new byte[(int)Math.pow(10, i)]);
            System.out.println("sdbm(" + i + ") = " + unsignedToString(sdbm(buffer)));
        }
    }

    // from stackoverflow
    public static String unsignedToString(long n) {
        long temp = (n >>> 1) / 5;
        return String.format("%019d", temp) + (n - temp * 10);
    }
}
