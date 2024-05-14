// Definitions:
//Cámara 3D
import peasy.*;
PeasyCam cam;

//Tamaño de la malla
int puntosX = 50;
int puntosY = 30;

//Spring Layout

//Tipos de estructura
enum SpringLayout {STRUCTURED, BEND, SHEAR};

// Display and output parameters:
float timeStep = 0.05;
PVector fuerzaGravedad = new PVector (0,0,0); 
float gravedad = 4.9;
PVector viento = new PVector (0,0,0); 
boolean vientoActivo = false;
boolean gravedadActivo = false;
color banderas = color(255,191,105);