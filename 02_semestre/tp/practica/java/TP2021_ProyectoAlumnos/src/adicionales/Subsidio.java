/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package adicionales;

/**
 *
 * @author suare
 */
public class Subsidio {
    private double monto;
    private String motivo;
    private boolean otorgado;
    
    public Subsidio(double montoSolicitado, String unMotivo){
        monto = montoSolicitado;
        motivo = unMotivo;
        otorgado = false;
    }
    
    public boolean fueOtorgado() {
        return otorgado;
    }
    public double getMonto() {
        return monto;
    }
    public void otorgar() {
        otorgado = true;
    }
}
