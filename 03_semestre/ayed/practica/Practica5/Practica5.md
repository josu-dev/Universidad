# Resolucion TP 5

- ## 1

    - ### a

        | N° Cuentas (y consultas) | procesarMovimientos | procesarMovimientosOptimizado |
        | :-: | :-: | :-: |
        | 1000 | 0.028 | 0.001 |
        | 10000 | 0.482 | 0.007 |
        | 25000 | 3.778 | 0.018 |
        | 50000 | 17.559 | 0.028 |
        | 100000 | 68.889 | 0.036 |

    - ### b

        Porque se acceden multiples veces a las mismas cuentas

    - ### c

        Es mas eficiente porque hace un uso optimo de los accesos por numero de cuenta sumando solo cuando es necesario


- ## 2

    | N | Lineal | Dicotomica |
    | :-: | :-: | :-: |
    | 100000 | 2 | 0 |
    | 200000 | 2 | 0 |
    | 300000 | 4 | 0 |
    | 400000 | 2 | 0 |
    | 500000 | 3 | 0 |
    | 600000 | 3 | 0 |


- ## 3

    Unas corren en tiempo constante porque son operaciones que bien no dependen del tamaño del arraylist en si mismo o sus valores son atributos

    Otras corren en tiempo linea hablando bruscamente porque dependen del tamaño del arraylist


- ## 4

    - ### a

            3^n es de O(2^n)

        Es falso ya que si f(n) = 3^n, O(f(n)) = O(3^n)

        3^n crece mas rapido que 2^n

    - ### b

            n + log_2(n) es de O(n)
        
        Es verdadero ya que cuando se tiene

        f(n) = n, g(n) = log_2(n), h(n)= f(n) + g(n)

        O(h(n)) = max(O(f(n)), O(g(n)))

        O(h(n)) = max(O(n), O(log_2(n)))

        O(h(n)) = O(n) crece mas rapido que O(log_2(n))

    - ### c

            n^1/2 + 10^20 es de O(n^1/2)

        Es verdadero

        En O las constantes se descartan

        10^20 es una constante en forma de potencia

        Solo queda n^1/2 por ende es O(n^1/2)

    - ### d

            | 3n + 17, n < 100
            | 317 , n>= 100

        Es verdadero ya que en el peor caso 3n es el monomio de grado mayor, descartando su coeficiente nos queda n, por ende es O(n)

    - ### e

            Mostrar que p(n) = 3n^5 + 8n^4 + 2n +1 es O(n5)

        Es verdad

        Las constantes se descartan

        Los coeficientes se descartan

        Un polinomio es suma de funciones

        Por ende la expresion original es equivalente a:

        O(p(n)) = max(O(n^5), O(n^4), O(n))

        El mayor es n^5 por ende la funcion es O(n^5)

    - ### f

            Si p(n) es un polinomio de grado k, entonces p(n) es O(nk)

        Es verdad

        Como en el punto anterior, constantes no se tienen en cuenta, coeficientes son presindibles, la funcion mayor de la composicion equivalente es el monomio con mayor grado del polinomio


- ## 5

    ```java
    public class Ejercicio4 {
        private static Random rand = new Random();
        public static int[] randomUno(int n) {
            int i, x = 0, k;
            int[] a = new int[n];
            for (i = 0; i < n; i++) {
                boolean seguirBuscando = true;
                while (seguirBuscando) {
                    x = ran_int(0, n - 1);
                    seguirBuscando = false;
                    for (k = 0; k < i && !seguirBuscando; k++)
                        if (x == a[k])
                            seguirBuscando = true;
                }
                a[i] = x;
            }
            return a;
        }
        public static int[] randomDos(int n) {
            int i, x;
            int[] a = new int[n];
            boolean[] used = new boolean[n];
            for (i = 0; i < n; i++)
                used[i] = false;
            for (i = 0; i < n; i++) {
                x = ran_int(0, n - 1);
                while (used[x])
                    x = ran_int(0, n - 1);
                a[i] = x;
                used[x] = true;
            }
            return a;
        }
        public static int[] randomTres(int n) {
            int i;
            int[] a = new int[n];
            for (i = 0; i < n; i++)
                a[i] = i;
            for (i = 1; i < n; i++)
                swap(a, i, ran_int(0, i - 1));
            return a;
        }
        private static void swap(int[] a, int i, int j) { 
            int aux;
            aux = a[i];
            a[i] = a[j];
            a[j] = aux;
        }
        /** Genera en tiempo constante, enteros entre i y j con igual probabilidad.
        */
        private static int ran_int(int a, int b) {
            if (b < a || a < 0 || b < 0)
                throw new IllegalArgumentException("Parametros 
            invalidos");
            return a + (rand.nextInt(b - a + 1));
        }
        public static void main(String[] args) {
            System.out.println(Arrays.toString(randomUno(1000)));
            System.out.println(Arrays.toString(randomDos(1000)));
            System.out.println(Arrays.toString(randomTres(1000)));
        }
    }
    ```

    - ### a

        Random 1 y 2 pueden quedar en loop infinito pero en algun momento cortan

    - ### b

        - Random 1 realiza n operaciones por x veces que intente un numeor por la cantidad de numeros que se lleven en el momento agregados al intentar calcular un random

        - Random 2 realiza n operaciones mas n operaciones por la cantidad de veces que le lleve calcular un numero no usado

        - Random 3 realiza n operaciones mas n operaciones


- ## 6

    - ### a

        10000 operaciones/s

        f(n) = n * log_10(n)

        n = 10000

        f(10000) = 10000 * log_10(10000) = 10000 * 4 = 40000

        40000 / 10000/s = 4 s

    - ### b

        ALGO-1 = 100n^3

        - i

            si entrada es n, O es 100(n)^3

            si entrada es 2n, O es 100(2n)^3

            100*8n^3 = 8(100n^3)

            El ALGO seria 8 veces mas lento

        - ii

            El algo seria 27 veces mas lento


- ## 7