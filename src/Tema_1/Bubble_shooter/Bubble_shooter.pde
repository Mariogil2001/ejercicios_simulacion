PVector a, b, dir, p;
float dt;

void setup() {
  size(600, 600);
  dt = 0.1;
  a = new PVector(height/2, width);
  b = new PVector();
  dir = new PVector();
  p = new PVector();
}

void draw() {
  background(#264653);
  puntoA();
  // 3. Mover la bola en esa dirección.
  p.add(PVector.mult(dir, dt)); // Mueve la partícula en la dirección calculada
  particula();
  puntoB();
  linea();
}
void mouseClicked(){
    // 1. Crear una nueva bola en la posición inicial cuando se hace clic.
    p = new PVector(a.x, a.y);
    // 2. Calcular la dirección entre la posición de la bola inicial y la posición del mouse.
    dir = PVector.sub(new PVector(mouseX, mouseY), p).normalize().mult(75);
}
void puntoA(){
  stroke(0);
  fill(#f4a261);
  ellipse(a.x,a.y,80,80);
}

void puntoB(){
  stroke(#edede9);
  fill(#edede9);
  ellipse(mouseX, mouseY, 5, 5);
}

void particula(){
  stroke(0);
  fill(#2a9d8f);
  ellipse(p.x, p.y, 20, 20);
}

// Función para dibujar la línea entre el punto A y el punto B
void linea(){
  stroke(#edede9);
  line(a.x, a.y, mouseX, mouseY);
}
