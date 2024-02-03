/*Ejercicio Movimiento de bola alrededor de un punto*/
float t, w, r, x, y;
PVector p; 

void setup() {
  size(600,600);
  r = 150; // Radio de la circunferencia a seguir
  p = new PVector(width/2 + r, height/2); // Particula
  t = 1; // Periodo -> Tiempo en recorrer una onda completa
  w = (2 * PI) / t; // Fórmula de la velocidad angular
}

void draw(){
  background(#FAF0CA);
  particula();
}

void particula(){
  // Calcular las coordenadas x y y de la bola utilizando funciones trigonométricas
  x = width/2 + r * cos(w * millis() / 1000); // millis() devuelve el tiempo transcurrido en milisegundos
  y = height/2 + r * sin(w * millis() / 1000);
  // println(millis());
  
  // Dibujar el círculo de la trayectoria
  stroke(200); // Color de la trayectoria
  strokeWeight(2); // Grosor del borde
  noFill();
  ellipse(width/2, height/2, 2*r, 2*r);
  
  //Particula P
  stroke(#0D3B66);
  fill(#EE964B);
  ellipse(x, y, 25, 25);
}
