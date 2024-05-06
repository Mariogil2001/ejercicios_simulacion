// Particle System class
class ParticleSystem {
  ArrayList<Particle> _particles;
  PVector _source;

  ParticleSystem(PVector source) {
    _particles = new ArrayList<Particle>();
    _source = source.copy();
  }

  void addParticle() {
    _particles.add(new Particle(_source, acceleration, lifespan, mass));
  }

  void update() {
    for (int i = _particles.size() - 1; i >= 0; i--) {
      Particle particle = _particles.get(i);
      particle.update();
      if (particle.isDead()) {
        _particles.remove(i);
      }
    }
  }

  void display() {
    for (Particle particle : _particles) {
      particle.display();
    }
  }
}