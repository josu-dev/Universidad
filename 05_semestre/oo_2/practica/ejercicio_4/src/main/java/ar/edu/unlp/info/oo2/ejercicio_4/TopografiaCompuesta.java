package ar.edu.unlp.info.oo2.ejercicio_4;

import java.util.ArrayList;
import java.util.List;

public class TopografiaCompuesta extends Topografia {
    private List<Topografia> topografias;

    TopografiaCompuesta(
            Topografia topografia1,
            Topografia topografia2,
            Topografia topografia3,
            Topografia topografia4) {
        this.topografias = new ArrayList<>();
        this.topografias.add(topografia1);
        this.topografias.add(topografia2);
        this.topografias.add(topografia3);
        this.topografias.add(topografia4);
    }

    TopografiaCompuesta(List<Topografia> topografias) {
        this.topografias = topografias;
    }

    TopografiaCompuesta() {
        this.topografias = new ArrayList<>();
    }

    public boolean addTopografia(Topografia topografia) {
        if (topografias.size() == 4) {
            return false;
        }
        return this.topografias.add(topografia);
    }

    public Double getProporcionAgua() {
        return this.topografias.stream()
                .mapToDouble(topografia -> topografia.getProporcionAgua())
                .average()
                .orElse(0);
    }

    public Boolean equals(Topografia topografia) {
        if (!(topografia instanceof TopografiaCompuesta) || topografia == null) {
            return false;
        }

        for (int i = 0; i < 4; i++) {
            if (!this.topografias.get(i).equals(
                    ((TopografiaCompuesta) topografia).topografias.get(i))) {
                return false;
            }
            ;
        }
        return true;
    };
}
