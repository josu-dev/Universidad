package exer5;

public class Analizer {
    public static int min = 0;
    public static int max = 0;
    public static int prom = 0;

    public static int[] calcMinMaxProm(int[] src) {
        int[] calcs = new int[3];
        
        int min= 9999,max=0,total=0;

        for (int i=0; i<src.length; i++) {
            if (min>src[i]) min= src[i];
            if (max<src[i]) max= src[i];
            total+= src[i];
        }

        calcs[0]= min;
        calcs[1]= max;
        calcs[2]= (int)(total/src.length);
        return calcs;
    }
    
    public static void calcMinMaxProm(int[] src, MinMaxProm data) {
        int min= 9999,max=0,total=0;

        for (int i=0; i<src.length; i++) {
            if (min>src[i]) min= src[i];
            if (max<src[i]) max= src[i];
            total+= src[i];
        }

        data.min= min;
        data.max= max;
        data.prom= (int)(total/src.length);
    }

    public static void calcMinMaxPromOnClass(int[] src) {
        int min= 9999,max=0,total=0;

        for (int i=0; i<src.length; i++) {
            if (min>src[i]) min= src[i];
            if (max<src[i]) max= src[i];
            total+= src[i];
        }

        Analizer.min= min;
        Analizer.max= max;
        Analizer.prom= (int)(total/src.length);
    }
}
