/* Ejercicio Montaña Rusa */
float dt = 0.1; // Diferencial de tiempo, mas sensible y mas importante
PVector a, b, c,  p, velAB, velBC;
float accAB = -.1; // Aceleración en el tramo AB, da sensacion que le cuesta subir
float accBC = 2.5; // Aceleración en el tramo BC, da sensacion de que va mas rapido

void setup(){
  size(800, 600); // Abrir una ventana
  a = new PVector(width/2 - 0.4*width, height/2); // Posicion del punto A
  b = new PVector(width/2, height/2 - 0.2*height); // Posicion del punto B
  c = new PVector(width/2 + 0.2*width, height/2 + 0.2*height); // Posicion del punto C
  p = new PVector(width/2 - 0.4*width, height/2); // Posicion inicial de la particula (punto A)

  velAB = PVector.sub(b,a).normalize().mult(10); // Saca la direccion
  velBC = PVector.sub(c,b).normalize().mult(10);
  //println(velAB);
  //println(a);
  //println(b);
  //println(c);
  // vel = b.sub(a); Metodo chungo q manda a cuenca a b

}

void draw(){
  background(#f1f2f6);
  lineaAB();
  lineaBC();
  particula();
  puntoA();
  puntoB();
  puntoC();
  //ellipse(mouseX, mouseY, 40, 40); //Creamos una ellipse
  
  //p.x += velAB.x * dt;
  //p.y += velAB.y * dt;
  
  /* Verificar si la partícula ha alcanzado el punto B
  if (p.dist(b) <= 1) {
    velAB = velBC;
    println(velAB);
  }
  p.add(PVector.mult(velAB,dt)); // Para velocidad constante
  */
  // Actualizar la velocidad y posición según la aceleración en el tramo AB
  if (p.x < b.x) {
    velAB.add(PVector.mult(velAB.copy().normalize(), accAB * dt));
    p.add(PVector.mult(velAB, dt));
  }
  
  // Actualizar la velocidad y posición según la aceleración en el tramo BC
  if (p.x >= b.x && p.x < c.x) {
    velBC.add(PVector.mult(velBC.copy().normalize(), accBC * dt));
    p.add(PVector.mult(velBC, dt));
  }
  println(p);
}
void particula(){
  //Particula P
  stroke(0,255,0);
  fill(0,200,0);
  ellipse (p.x,p.y,25,25);
}
void puntoA(){
  stroke(0);
  fill(#758bfd);
  ellipse(a.x, a.y, 20, 20);
 }
 
void puntoB(){
  stroke(0);
  fill(#ff8600);
  ellipse(b.x, b.y, 20, 20);
}
void puntoC(){
  stroke(0);
  fill(#fcbf49);
  ellipse(c.x, c.y, 20, 20);
}
void lineaAB(){
  stroke(0);
  line(a.x,a.y,b.x,b.y);
}
void lineaBC(){
  stroke(0);
  line(b.x,b.y,c.x,c.y);
}
