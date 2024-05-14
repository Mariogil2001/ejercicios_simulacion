class Nodo {

    // Variables de instancia
    private PVector posicion;
    private PVector velocidad;
    private PVector aceleracion;

    // Constructor
    Nodo(float x, float y) {
        this.posicion = new PVector(x, y);
        this.velocidad = new PVector(random(-10, 10), random(-10, 10));
        this.aceleracion = new PVector(0, 0);
    }

    // Métodos
    void update() {
        // Aplicar fuerza de gravedad
        aplicarFuerza(PVector.mult(GRAVEDAD, MASA));
        // Actualizar velocidad y posición
        velocidad.add(PVector.mult(aceleracion, DT));
        posicion.add(PVector.mult(velocidad, DT));
        aceleracion.set(0, 0);
    }
    
    // Método para aplicar una fuerza
    void aplicarFuerza(PVector fuerza) {
        PVector f = fuerza.copy();
        f.div(MASA);
        aceleracion.add(f);
    }

    void display() {
        noStroke();
        fill(COLOR_PELO);
        ellipse(posicion.x, posicion.y, 1, 1);
    }
}