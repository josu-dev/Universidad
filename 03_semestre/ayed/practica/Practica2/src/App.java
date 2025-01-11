import tp02.ejercicio4.TestBalanceo;

public class App {
    public static void main(String[] args) throws Exception {
        System.out.println("Hello, World!");
        TestBalanceo test = new TestBalanceo();
        System.out.println(
            test.esBalanceada("{ ( ) [ ( ) ] }") + "\n" +
            test.esBalanceada("()")
        );
    }
}
