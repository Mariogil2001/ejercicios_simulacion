// Global variables
ParticleSystem particleSystem;
PVector source;
PVector acceleration = new PVector(0, 0.07);
float lifespan = 255;
float radius = 8;
float mass = 0.0001;
float gravity = 9.8;

void setup() {
  size(800, 600);
  source = new PVector(width / 2, height);
  particleSystem = new ParticleSystem(source);
}

void draw() {
  background(255);
  particleSystem.addParticle();
  particleSystem.update();
  particleSystem.display();
}
