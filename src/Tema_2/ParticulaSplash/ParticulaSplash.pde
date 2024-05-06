// Problema 1 - Modelo de flotabilidad :  //<>//
// Plantilla basica para problemas de simulacion

// 3 pasos: 
//   a) Definir la funcion a(s(t), v(t)) en base a las fuerzas del problema y las condiciones iniciales del escenario
//   b) Definir una funcion para el integrador a emplear (Euler Explicito)
//   c) Simular: Integrar numericamente la aceleracion y la velocidad de la particula a dt's. (y pintar)

// Condiciones o parametros del problema:
final float   M    = 10.0;   // Particle mass (kg)
final float   Gc   = 0.98;   // Gravity constant (m/(s*s))
final PVector G    = new PVector(0.0, Gc);   // Acceleration due to gravity (m/(s*s))
final PVector froz = new PVector(0.0, 0.0);   // Friction force (N)
float         K    = 0.2;     // Friction constant (N·s/m)
final PVector S0   = new PVector(10.0, 10.0);   // Particle's start position (pixels)

boolean       hasSplashed = false;   // Is the particle floating?
float water_height;   // Water level (pixels)
float water_friction = 0.4;   // Water friction constant (N·s/m)

PVector _s  = new PVector();   // Position of the particle (pixels)
PVector _v  = new PVector();   // Velocity of the particle (pixels/s)
PVector _a  = new PVector();   // Accleration of the particle (pixels/(s*s))
PVector _v0 = new PVector();   // Initial velocity of the particle (pixels/s)

Particle p;
PVector pos_ini;
float r = 60;
float m = 5;
float d = 0.00001;
// Añade una lista para almacenar los efectos de salpicadura
ArrayList<Splash> splashes = new ArrayList<Splash>();

/////////////////////////////////////////////////////////////////////
// Parameters of the numerical integration:
float         SIM_STEP = .02;   // dt = Simulation time-step (s)
float         _simTime;
////////////////////////////////////////////////////////////////////////////77

// Ley de Newton: 
//      a(s(t), v(t)) = [Froz(v(t)) + Fpeso ]/m
//      Froz = -k·v(t)
//      Fpeso = mg; siendo g(0, -9.8) m/s²
//      
// Simulación de la flotabilidad de una particula.
void settings()
{
    size(600, 600);
}

void setup()
{
  frameRate(60);
  
  pos_ini = new PVector(width/2, 100);
  p = new Particle(pos_ini,r, m, d);
  water_height = height/1.5;
}

void draw() {
  background(2, 48, 71);
   
  p.run();

  // Dibuja el agua
  noStroke();
  fill(142, 202, 230, 100);
  rect(0, water_height, width, height);

  // Comprueba si la partícula ha tocado el agua
  if (!hasSplashed && p._position.y >= water_height && p._velocity.y > 0.01) {
    // Crea un nuevo efecto de salpicadura y añádelo a la lista
    splashes.add(new Splash(p._position));
    hasSplashed = true;
  }

  // Actualiza y muestra cada efecto de salpicadura
  for (int i = splashes.size() - 1; i >= 0; i--) {
    Splash s = splashes.get(i);
    s.run();
    // Elimina el efecto de salpicadura si ha terminado
    if (s.isDead()) {
      splashes.remove(i);
    }
  }
}

void keyPressed()
{
  if (key == 'r' || key == 'R')
  {
    hasSplashed = false;
    setup();
  }
 
}