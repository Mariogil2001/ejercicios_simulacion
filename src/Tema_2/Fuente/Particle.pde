class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float mass;

  Particle(PVector position, PVector acceleration, float lifespan, float mass) {
    this.position = position.copy();
    this.velocity = new PVector(random(-1, 1), random(-5, -1));
    this.acceleration = acceleration.copy();
    this.lifespan = lifespan;
    this.mass = mass;
  }

  void update() {
    PVector gravity_force = new PVector(0, gravity * mass); // Fuerza de gravedad
    acceleration.add(gravity_force); // Agregar gravedad a la aceleración
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 2;
  }

  void display() {
    stroke(#8ecae6, lifespan / 10);
    fill(#8ecae6, lifespan);
    ellipse(position.x, position.y, radius, radius);
  }

  boolean isDead() {
    return lifespan < 0;
  }
}