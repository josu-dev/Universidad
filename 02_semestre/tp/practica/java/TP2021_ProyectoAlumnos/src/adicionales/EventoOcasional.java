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
public class EventoOcasional extends Recital{
    private String motivo;
    private String nombreContratador;
    private String dia;
    private boolean sucedio;

    public EventoOcasional( String nombreBanda, int cantidadTemas, String motivo, String nombreContratador, int dia) {
        super( nombreBanda, cantidadTemas );
        this.motivo = motivo;
        this.sucedio = false;
    }
    public String getMotivo() {
        return motivo;
    }

    public void setMotivo(String motivo) {
        this.motivo = motivo;
    }

    public String getNombreContratador() {
        return nombreContratador;
    }

    public void setNombreContratador(String nombreContratador) {
        this.nombreContratador = nombreContratador;
    }

    public String getDia() {
        return dia;
    }

    public void setDia(String dia) {
        this.dia = dia;
    }
    
    public void actuar() {
        if (motivo.equals( "show de beneficiencia" )) System.out.println( "Recuerden colaborar con " + nombreContratador);
        else if (motivo.equals( "show de TV" )) System.out.println( "Saludos amigos televidentes" );
        else System.out.println( "Un feliz cumpleaños para " +  nombreContratador );
        
        super.actuar();
        this.sucedio = true;
    }
    
    public boolean finalizado() {
        return sucedio;
    }
    
    public double calcularCosto(){
        if (motivo.equals( "show de beneficiencia" )) return 0;
        if (motivo.equals( "show de TV" )) return 50000;
        return 150000;
    }
}
