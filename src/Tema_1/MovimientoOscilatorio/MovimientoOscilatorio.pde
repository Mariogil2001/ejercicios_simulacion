float x, y, v;
ArrayList<PVector> trayectoria; // Arraylist para almacenar las coordenadas de la trayectoria

void setup() {
  size(600, 400);
  trayectoria = new ArrayList<PVector>();
  v = 0.1; // Aumenta la velocidad para alargar el movimiento en el eje x
}

void draw() {
  background(#FAF0CA);

  particula();
  dibujarTrayectoria(); // Llamar a la función para dibujar la trayectoria
}

void particula() {
  // Calcular las coordenadas x y y de la bola utilizando funciones trigonométricas
  x += v; // Incrementa la posición en x con la velocidad
  
  y = height/2 + 50* (0.5 * sin(3*x) + 0.5*sin(3.5*x)); // Mantiene la misma amplitud en y
  
  trayectoria.add(new PVector(x, y)); // Agregar las coordenadas a la trayectoria
  
  // Particula P
  stroke(#0D3B66);
  fill(#EE964B);
  ellipse(x, y, 20, 20);
}

void dibujarTrayectoria() {
  noFill();
  stroke(0,0,0); // Color rojo para la trayectoria
  beginShape();
  for (PVector punto : trayectoria) {
    vertex(punto.x, punto.y);
  }
  endShape();
}
