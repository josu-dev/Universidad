package tp02.ejercicio4;

import tp02.ejercicio3.PilaGenerica;

public class TestBalanceo {
    private PilaGenerica<Character> pila = new PilaGenerica<Character>();

    public boolean esBalanceada(String S) {
        boolean balanceada = true;

        if (S == "") return true;

        int i = 0;
        while (balanceada & i<S.length()) {
            char c = S.charAt(i);
            i++;
            if (c == ' ') continue;
            if ("([{".indexOf(c) > -1){
                this.pila.apilar(c);
            }
            else {
                if (this.pila.esVacia()) {
                    balanceada = false;
                }
                else {
                    char ultimo = this.pila.tope();
                    switch (ultimo) {
                        case '(':
                            if (c != ')') {
                                balanceada = false;
                            }
                            else {
                                this.pila.desapilar();
                            }
                            break;
                        case '[':
                            if (c != ']') {
                                balanceada = false;
                            }
                            else {
                                this.pila.desapilar();
                            }
                            break;
                        case '{':
                            if (c != '}') {
                                balanceada = false;
                            }
                            else {
                                this.pila.desapilar();
                            }
                            break;
                        default:
                            break;
                    }
                }
            }
        }

        return this.pila.esVacia();
    }
}
