// Malla Class: Defines the structure and updates the forces acting on it
class Malla
{
  SpringLayout _springLayout; // Layout of the spring

  PVector positionMatrix[][]; // Vertex matrix
  PVector forceMatrix[][]; // Force matrix
  PVector accelerationMatrix[][]; // Acceleration matrix
  PVector velocityMatrix[][]; // Velocity matrix
  
  int _numNodosX; // Number of nodes on the X axis
  int _numNodosY; // Number of nodes on the Y axis
  
  float distDirecta; // Rest length between direct vertices
  float distOblicua; // Rest length between diagonal vertices
  
  float k; // Spring constant between vertices
  float m_Damping; // Damping in the springs (Related to friction force)
  
  // Constructor
  Malla (SpringLayout springLayout, int x, int y)
  {
    _springLayout = springLayout; // Set the spring layout
    _numNodosX = x; // Set the number of nodes on the X axis
    _numNodosY = y; // Set the number of nodes on the Y axis
    
    positionMatrix = new PVector[_numNodosX][_numNodosY]; // Position vector
    forceMatrix = new PVector[_numNodosX][_numNodosY]; // Force vector
    accelerationMatrix = new PVector[_numNodosX][_numNodosY]; // Acceleration vector
    velocityMatrix = new PVector[_numNodosX][_numNodosY]; // Velocity vector
    
    distDirecta = 3; // Set the rest length between direct vertices
    distOblicua = sqrt(2* (distDirecta * distDirecta)); // Set the rest length between diagonal vertices
    
    // Adjust the elasticity and damping depending on the type of mesh
    m_Damping = 3; // Set the damping
    switch (_springLayout)
    {
      case STRUCTURED: 
        k = 400; // Set the spring constant for structured layout
      break;
      
      case BEND: 
        k = 150; // Set the spring constant for bend layout
      break;
      
      case SHEAR: 
        k = 300; // Set the spring constant for shear layout
      break;
    }
    
    // Initialize the position, force, acceleration, and velocity vectors for each node
    for (int i = 0; i < _numNodosX; i++)
    {
      for (int j = 0; j < _numNodosY; j++)
      {
        positionMatrix[i][j] = new PVector (i * distDirecta, j * distDirecta, 0);
        forceMatrix[i][j] = new PVector (0, 0, 0);
        accelerationMatrix[i][j] = new PVector (0, 0, 0);
        velocityMatrix[i][j] = new PVector (0, 0, 0);
      }
    }
  }

  void display(color c)
  {
    fill(c);
    for(int i = 0; i < _numNodosX-1; i++){
      beginShape(QUAD_STRIP);
      for(int j = 0; j < _numNodosY; j++){
        PVector p1 = positionMatrix[i][j];
        PVector p2 = positionMatrix[i+1][j];
        vertex(p1.x, p1.y, p1.z);
        vertex(p2.x, p2.y, p2.z);
      }
      endShape();
    }
    
  }
  
  void update() {
    actualizaFuerzas();
    for (int i = 0; i < _numNodosX; i++) {
      for (int j = 0; j < _numNodosY; j++) {
        accelerationMatrix[i][j].add(PVector.mult(forceMatrix[i][j], timeStep));
        velocityMatrix[i][j].add(PVector.mult(accelerationMatrix[i][j], timeStep));
        positionMatrix[i][j].add(PVector.mult(velocityMatrix[i][j], timeStep));

        if ((i == 0 && j == 0) || (i == 0 && j == _numNodosY - 1)) {
          forceMatrix[i][j].set(0, 0, 0);
          velocityMatrix[i][j].set(0, 0, 0);
          positionMatrix[i][j].set(i * distDirecta, j * distDirecta, 0);
        }
        accelerationMatrix[i][j].mult(0);
      }
    }
  }

  void actualizaFuerzas() {
    PVector v_Damping = new PVector(0, 0, 0);
    PVector vertexPos, fViento;

    for (int i = 0; i < _numNodosX; i++) {
      for (int j = 0; j < _numNodosY; j++) {
        forceMatrix[i][j].set(0, 0, 0);
        vertexPos = positionMatrix[i][j];

        forceMatrix[i][j].set(fuerzaGravedad.x, fuerzaGravedad.y, fuerzaGravedad.z);

        fViento = getfViento(vertexPos, i, j);
        forceMatrix[i][j].add(fViento);

        for (int di = -1; di <= 1; di += 2) {
          for (int dj = -1; dj <= 1; dj += 2) {
            forceMatrix[i][j].add(getForce(vertexPos, i + di, j, distDirecta, k));
            forceMatrix[i][j].add(getForce(vertexPos, i, j + dj, distDirecta, k));

            if (_springLayout == SpringLayout.BEND) {
              forceMatrix[i][j].add(getForce(vertexPos, i + 2 * di, j, distDirecta * 2, k));
              forceMatrix[i][j].add(getForce(vertexPos, i, j + 2 * dj, distDirecta * 2, k));
            }

            if (_springLayout == SpringLayout.SHEAR) {
              forceMatrix[i][j].add(getForce(vertexPos, i + di, j + dj, distOblicua, k));
            }
          }
        }
        v_Damping.set(velocityMatrix[i][j]);
        v_Damping.mult(-m_Damping);

        forceMatrix[i][j].add(v_Damping);
      }
    }
  }
  PVector getfViento(PVector v, int i, int j) {
    PVector fuerza = new PVector(0,0,0);
    PVector normal = new PVector(0,0,0);
    float proyeccion;
    
    PVector[] normals = {
      getNormal(v, i-1, j, i, j-1),
      getNormal(v, i-1, j, i, j+1),
      getNormal(v, i, j+1, i+1, j),
      getNormal(v, i+1, j, i, j-1)
    };
    
    int cont = 0;
    
    for (PVector n : normals) {
      if (n.mag() > 0) {
        normal.add(n);
        cont++;
      }
    }
    
    if (cont > 0) {
      normal.div(cont);
      normal.normalize(); // Normalize the vector that indicates the normal
  
      proyeccion = normal.dot(viento); // Project the normal onto the wind, and that will be the force
                       // that applies the wind speed to the flags
      fuerza.set(abs(proyeccion*viento.x), (proyeccion*viento.y), (proyeccion*viento.z));
    }
    
    return fuerza;
  }
  PVector getNormal(PVector v, int a, int b, int c, int d) {
    PVector n = new PVector(0, 0, 0);

    if (a >= 0 && a <= _numNodosX - 1 && b >= 0 && b <= _numNodosY - 1 && c >= 0 && c <= _numNodosX - 1 && d >= 0 && d <= _numNodosY - 1) {
      n = PVector.sub(positionMatrix[a][b], v).cross(PVector.sub(positionMatrix[c][d], v)); // Calculate the normal vector using cross product
    }

    return n;
  }

  PVector getForce(PVector VertexPos, int i, int j, float m_Distance, float k) {
    PVector force = new PVector(0.0, 0.0, 0.0);

    if (i >= 0 && i < _numNodosX && j >= 0 && j < _numNodosY) {
      PVector distancia = PVector.sub(VertexPos, positionMatrix[i][j]); // Calculate the distance vector
      float elongacion = distancia.mag() - m_Distance; // Calculate the elongation

      force = PVector.mult(distancia.normalize(), -k * elongacion); // Calculate the elastic force
    }

    return force;
  }
  
  
}