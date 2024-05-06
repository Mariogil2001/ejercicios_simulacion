// Problema 6 - Simulador aceleración coche :  //<>//
// Plantilla basica para problemas de simulacion

// 3 pasos: 
//   a) Definir la funcion a(s(t), v(t)) en base a las fuerzas del problema y las condiciones iniciales del escenario
//   b) Definir una funcion para el integrador a emplear (Euler Explicito)
//   c) Simular: Integrar numericamente la aceleracion y la velocidad de la particula a dt's. (y pintar)

// Condiciones o parametros del problema:
final float   M  = 10.0;   // Particle mass (kg)
final float   Gc = 9.8;   // Gravity constant (m/(s*s))
final PVector G  = new PVector(0.0, -Gc);   // Acceleration due to gravity (m/(s*s))
float         K  = 3;     // Coefieciente de rozamiento
final PVector S0 = new PVector(20.0, 20.0);   // Particle's start position (pixels)
final float   impulsador = 100.0;  // Fuerza que ejerce el impulsador

PVector _s  = new PVector();   // Position of the particle (pixels)
PVector _v  = new PVector();   // Velocity of the particle (pixels/s)
PVector _a  = new PVector();   // Accleration of the particle (pixels/(s*s))
PVector _v0 = new PVector();

PVector Fimpulsador = new PVector(0.0, 0.0);
PVector Froz = new PVector(0.0, 0.0);

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
// Simulacion aceleracion de un coche a partir de plantilla de tiro parabolico.


// Funcion que calcula la aceleracion de la particula en funcion de la posicion y la velocidad
PVector calculateAcceleration(PVector s, PVector v)
{
    PVector Froz = new PVector(0.0, 0.0);
    if(v.mag() > 0.01) { // Umbral de velocidad
        Froz = PVector.mult(v,-K);
    }
    PVector SumF  = PVector.add(Froz, Fimpulsador);
  
    PVector a = SumF.div(M);

    return a;
}
void AplicarPotencia() {
    PVector normal_aceleracor = new PVector(1.0,0.0);
    normal_aceleracor.normalize();
    Fimpulsador = PVector.mult(normal_aceleracor,impulsador);
}

void settings()
{
    size(600, 600);
}

void setup()
{
  frameRate(60);
  
  _v0.set(0.0, 0.0);
  _s = S0.copy();
  _v.set(_v0.x, _v0.y);
  _a.set(0.0, 0.0);
  _simTime = 0;
}

void draw()
{
  background(#ffbf69);
 
  drawScene();
  updateSimulation();
  
  if (_s.y < 0){
    println(_s);
    exit();
  }
}

void drawScene()
{
  int radio = 20;
  
  translate(0,height/2);
  strokeWeight(3);
  fill(#3a86ff);
  
  if(_s.x >= width){
    _s.x = radio;
    _s.y += radio;
  }
  circle(_s.x, -_s.y, radio);
  
//   // Aproximacion mediante integrador numerico
//   strokeWeight(1);
//   fill(200,0,0);
//   circle(s_a.x, -s_a.y, radio); 
  
}


void updateSimulation()
{
  
  _simTime += SIM_STEP;
  PVector acel =  calculateAcceleration(_s, _v);
  
  _v.add(PVector.mult(acel, SIM_STEP));
  _s.add(PVector.add(PVector.mult(_v, SIM_STEP), PVector.mult(acel, 0.5 * SIM_STEP * SIM_STEP)));

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
    if(key == 'a' || key == 'A')
    {
        AplicarPotencia();
    }
    else if (key == 'r' || key == 'R')
    {
        setup();
    }
}

void keyReleased()
{
    if(key == 'a' || key == 'A')
    {
        Fimpulsador.set(0.0, 0.0);
    }
}