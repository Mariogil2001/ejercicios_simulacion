// Problema - Plano Inclinado :  //<>//
// Plantilla basica para problemas de simulacion

// 3 pasos: 
//   a) Definir la funcion a(s(t), v(t)) en base a las fuerzas del problema y las condiciones iniciales del escenario
//   b) Definir una funcion para el integrador a emplear (Euler Explicito)
//   c) Simular: Integrar numericamente la aceleracion y la velocidad de la particula a dt's. (y pintar)

// Condiciones o parametros del problema:
final float   M  = 10.0;   // Particle mass (kg)
final float   Gc = 9.8;   // Gravity constant (m/(s*s))
final PVector G  = new PVector(0.0, -Gc);   // Acceleration due to gravity (m/(s*s))
float         K  = 0.2;     // Coefieciente de rozamiento
final PVector S0 = new PVector(10.0, 10.0);   // Particle's start position (pixels)
float theta = PI / 6; // Inclinación del plano

PVector _s  = new PVector();   // Position of the particle (pixels)
PVector _v  = new PVector();   // Velocity of the particle (pixels/s)
PVector _a  = new PVector();   // Accleration of the particle (pixels/(s*s))
PVector _v0 = new PVector();
PVector v_a = new PVector();
PVector s_a = new PVector();   // Position of the particle (pixels)

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
// Calculo de fuerzas para un plano inclinado.
PVector calculateAcceleration(PVector s, PVector v)
{

    PVector Unitario = new PVector(cos(theta), sin(theta));
    PVector Froz  = PVector.mult(Unitario, PVector.mult(v,-K).mag());
    PVector Fpeso = PVector.mult(Unitario, PVector.mult(G,M).mag());

    PVector SumF  = PVector.add(Froz, Fpeso);
    
    PVector a = SumF.div(M);

    return a;
}

void settings()
{
    size(500, 300);
}

void setup()
{
  frameRate(60);
  
  _v0.set(0, 0);
  _s = S0.copy();
  _v.set(_v0.x, _v0.y);
  _a.set(0.0, 0.0);
  _simTime = 0;
}

void draw()
{
  background(#faedcd);
 
  drawScene();
  updateSimulation();

  // Si la partícula se sale de la pantalla, termina la simulación
  if (_s.y < 0){
    println(_s);
    exit();
  }
}

void drawScene()
{
    int radio = 20;
    
    strokeWeight(3);
    fill(#ccd5ae);
    // Solucion analitica
    circle(_s.x, _s.y - radio, radio);
      
    // Dibujar el plano inclinado
    float x = width;
    float y = tan(theta) * x;
    line(0, 0, x, y);   
}

void updateSimulation()
{
  //updateSimulationExplicitEuler();
  updateSimulationSimplecticEuler();
  
  _simTime += SIM_STEP;
  
}

void updateSimulationExplicitEuler()
{

  PVector acel =  calculateAcceleration(_s, _v);
  
  _s.add(PVector.mult(_v, SIM_STEP));
  _v.add(PVector.mult(acel, SIM_STEP)); 
  
}

void updateSimulationSimplecticEuler()
{

  PVector acel =  calculateAcceleration(_s, _v);
  
  _v.add(PVector.mult(acel, SIM_STEP)); 
  _s.add(PVector.mult(_v, SIM_STEP));
  
}

void keyPressed()
{
  if (key == 'r' || key == 'R')
  {
    setup();
  }
 
}