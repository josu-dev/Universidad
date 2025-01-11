/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package randoms;

import Optimizados.GeneradorAleatorio;

/**
 *
 * @author suare
 */
public class Paciente {
    private String nombre;
    private double ultimaGlucosa;
    private double ultimaDosis;
    
    public Paciente(String nombre){
        this.nombre= nombre;
        ultimaGlucosa=0;
        ultimaDosis=0;
    }

    public void setUltimaGlucosa(double ultimaGlucosa) {
        this.ultimaGlucosa = ultimaGlucosa;
    }

    public String getNombre() {
        return nombre;
    }

    public double getUltimaGlucosa() {
        return ultimaGlucosa;
    }

    public double getUltimaDosis() {
        return ultimaDosis;
    }
    
    public void aplicarDosis(double D){
        ultimaDosis= D;
        ultimaGlucosa-= GeneradorAleatorio.generarInt(1);
    }
    
}
