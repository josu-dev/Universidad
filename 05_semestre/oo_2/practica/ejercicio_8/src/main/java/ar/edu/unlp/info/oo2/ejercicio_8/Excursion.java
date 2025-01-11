package ar.edu.unlp.info.oo2.ejercicio_8;

import java.time.LocalDate;

public class Excursion {
    private String nombre;
    private LocalDate fechaInicio;
    private LocalDate fechaFin;
    private String puntoDeEncuentro;
    private Double costo;
    private Integer cupoMaximo;
    private Integer cupoMinimo;
    private State state;

    Excursion(
            String nombre, LocalDate fechaInicio, LocalDate fechaFin,
            String puntoDeEncuentro, Double costo,
            Integer cupoMaximo, Integer cupoMinimo) {
        this.nombre = nombre;
        this.fechaFin = fechaFin;
        this.fechaInicio = fechaInicio;
        this.costo = costo;
        this.puntoDeEncuentro = puntoDeEncuentro;
        this.cupoMinimo = cupoMinimo;
        this.cupoMaximo = cupoMaximo;
        this.state = new StateInsuficiente(this);
    }

    private void setState(State state) {
        this.state = state;
    }

    public void inscribir(Usuario unUsuario) {
        this.setState(this.state.inscribir(unUsuario));
    }

    public String obtenerInformacion() {
        return this.nombre + ", " + this.costo + ", " +
                this.fechaInicio + ", " + this.fechaFin + ", " +
                this.puntoDeEncuentro + this.state.obtenerInformacion();
    }

    public Integer getCupoMinimo() {
        return this.cupoMinimo;
    }
    public Integer getCupoMaximo() {
        return this.cupoMaximo;
    }
}
