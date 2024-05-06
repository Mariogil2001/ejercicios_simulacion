class Particle {
  PVector _position; //posicion
  PVector _velocity; //velocidad
  PVector _acceleration; //aceleracion
  float _r; //radius
  float _m; //mass
  float _d; //density

  Particle(PVector posicion, float r, float m, float d) {
    _position = posicion.copy();
    _velocity = new PVector(0, 0);
    _acceleration = new PVector(0, 0.98);
    _r = r;
    _m = m;
    _d = d;
  }

  void run() {
    update();
    render();
  }

  void update() {
    applyGravity();
    calculateForces();
    updatePosition();
  }

  void render() {
    noStroke();
    fill(255, 183, 3);
    ellipse(_position.x, _position.y, _r, _r);
  }

  void applyGravity() {
    accelerate(PVector.mult(G, _m));
  }

  void calculateForces() {
    float buoyancy;
    PVector froz = new PVector(0, 0);
    PVector vFb = new PVector(0, 0);

    if (_position.y - _r >= water_height) { //dentro
      buoyancy = 5.0 * PI * pow(_r, 3) / 3.0;
      froz.y = - water_friction * _velocity.y;
    } else if (_position.y + _r / 2 > water_height && _position.y - _r / 2 < water_height) { //en la línea
      float h = _position.y + _r - height/1.5;
      float a = sqrt(2 * h * _r - pow(h, 2));
      buoyancy = (3 * pow(a,2) + pow(h, 2)) * PI * h / 6.0;
      froz.y = -water_friction * _velocity.y; 
    } else { //fuera
      buoyancy = 0;
      froz.y = 0;
    }

    vFb.y = - _d * G.y * buoyancy;
    accelerate(vFb);   
    accelerate(froz);
  }

  void updatePosition() {
    _velocity.add(_acceleration);
    _position.add(_velocity);
    _acceleration.mult(0); //Resetea la aceleracion
  }

  void accelerate(PVector forces) {
    PVector aux = forces.div(_m);
    _acceleration.add(aux);
  }
}