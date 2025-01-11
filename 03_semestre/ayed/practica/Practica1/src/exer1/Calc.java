package exer1;

public class Calc {
    
    public static void listNumbersFor(int a, int b) {
        for (int i=a; i<= b; i++) {
            System.out.println(i);
        }
    }

    public static void listNumbersWhile(int a, int b) {
        while (a <= b) {
            System.out.println(a++);
        }
    }

    public static void listNumbersRecursive(int a, int b) {
        if (a <= b) {
            System.out.println(a);
            listNumbersFor(++a, b);
        }
    }

    public static int[] firstNMultiples(int n) {
        int[] multiples = new int[n];

        for (int i= 0; i<n; i++) {
            multiples[i] = (i+1)*n;
        }
        return multiples;
    }

}
