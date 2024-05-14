//Simulación de banderas con interacción en gravedad y viento
//Generaremos 3 banderas con diferentes estructuras
Malla structuredMesh, bendMesh, shearMesh;

void setup()
{
  System.setProperty("jogl.disable.openglcore", "true");
  size (1777, 1000, P3D); //P3D usa la tarjeta gráfica para renderizar
  smooth(4); // Suaviza los bordes de las figuras, se puede quitar
  
  //Cámara:
  cam = new PeasyCam(this, 500, 0, 0, 600);
  cam.setMinimumDistance(0);
  cam.setMaximumDistance(1000);
  
  //Creación de las 3 banderas
  structuredMesh = new Malla (SpringLayout.STRUCTURED , puntosX, puntosY);
  bendMesh = new Malla (SpringLayout.BEND, puntosX, puntosY);
  shearMesh = new Malla (SpringLayout.SHEAR, puntosX, puntosY);
  
}
void draw()
{
  background(#caf0f8);
  translate(200, 0, 0);
  
  //Draw datos
  displayInfo();
  
  //BANDERA STRUCTURED
  drawStructuredFlag();
  
  //BANDERA BEND
  drawBendFlag();
  
  //BANDERA SHEAR
  drawShearFlag();
}

void drawStructuredFlag() {
  structuredMesh.update();
  
  structuredMesh.display(banderas);
  fill(0,0,0);
  
  text("STRUCTURED", 10, 270, 0);
  
  pushMatrix();
  translate(0, 127.5, 0); 
  box(4, 255, 4); 
  popMatrix();
}

void drawBendFlag() {
  bendMesh.update();
  
  pushMatrix();
  
  translate(255,0,0);
  
  bendMesh.display(banderas);
  fill(0,0,0);
  
  text("BEND", 10, 270, 0);
  
  pushMatrix();
  translate(0, 127.5, 0); 
  box(4, 255, 4); 
  popMatrix();
  
  popMatrix();
}

void drawShearFlag() {
  shearMesh.update();
  
  pushMatrix();
  
  translate(500,0,0);
  
  shearMesh.display(banderas);
  fill(0,0,0);
  
  text("SHEAR", 10, 270, 0);
  
  pushMatrix();
  translate(0, 127.5, 0); 
  box(4, 255, 4); 
  popMatrix();
  
  popMatrix();
}

//Interfaz de usuario
void keyPressed()
{
  if (key == 'v' || key == 'V')
  {
    vientoActivo = !vientoActivo; //Si está activo, se desactiva y viceversa
  }
  
  if (key == 'g' || key == 'G')
  {
    gravedadActivo = !gravedadActivo; //Si está activo, se desactiva y viceversa
  }
}

void displayInfo() {
  fill (0,0,0);
  
  text("SIMULA BANDERAS", 250, -150, 0);
  
  text("Tecla 'v' para cambiar el viento", -50, -90, 0);
  text("Tecla 'g' para cambiar la gravedad", -50, -70, 0);
  
  text("Fuerzas: ", 600, -120, 0);

  line(-100, 250, width, 250);
  
  //Relación ternaria para mostrar si está activado o desactivado, gracias curso de js
  //VIENTO
  text(vientoActivo ? "Viento activado" : "Viento desactivado", 600, -100, 0);
  viento.x = vientoActivo ? 0.5 - random(2, 7) : 0;
  viento.y = vientoActivo ? 0.1 - random(0, 0.2) : 0;
  viento.z = vientoActivo ? 0.5 + random(1, 6) : 0;
  
  //GRAVEDAD
  fuerzaGravedad.y = gravedadActivo ? gravedad : 0;
  text(gravedadActivo ? "Gravedad activada" : "Gravedad desactivada", 600, -80, 0);
}