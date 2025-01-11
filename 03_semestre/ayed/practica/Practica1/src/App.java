import java.util.Scanner;

import exer1.Calc;

public class App {
    public static void main(String[] args) throws Exception {
        System.out.println("Hello, World!");

        
        Scanner s = new Scanner(System.in);
        
        int n = s.nextInt();
        while (n != -1) {
            int[] myMultiples = Calc.firstNMultiples(n);

            for (int i=0; i<myMultiples.length; i++) {
                System.out.println(myMultiples[i]);
            }
            n = s.nextInt();
        }

        s.close();
    }
}
