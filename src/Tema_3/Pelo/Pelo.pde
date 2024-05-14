// Declaración de matrices de objetos Nodos y Arista
Nodo[][] vectorNodos;
Arista[][] vectorAristas;

// Método setup() se ejecuta una vez al inicio del programa
void setup() {
    size(1777, 1000);  // Define el tamaño de la ventana
    
    // Inicialización de matrices de objetos
    vectorNodos = new Nodo[TAM][CANTIDAD];
    vectorAristas = new Arista[TAM-1][CANTIDAD];
    
    // Llenado de las matrices con objetos
    inicializarMatrices();
}

// Método draw() se ejecuta continuamente después de setup()
void draw() {
    background(COLOR_FONDO);  // Define el color de fondo
    
    // Actualización y visualización de los objetos Arista y Nodos
    actualizarYDibujarObjetos();
}

// Método keyPressed() se ejecuta cuando se presiona una tecla
void keyPressed() {
    if (key == 'r')  // Si la tecla presionada es 'r'
        setup();     // Se vuelve a ejecutar el método setup()
}

// Método para inicializar las matrices de nodos y aristas
void inicializarMatrices() {
    for (int k = 0; k < CANTIDAD; k++) {
        for (int i = 0; i < TAM; i++) {
            // Creación de nuevos objetos Nodos con posiciones aleatorias
            vectorNodos[i][k] = new Nodo( width/2 + random(-5, 5) + i * LONGITUD + k , 50);
        }
        for (int i = 0; i < TAM-1; i++) {
            // Creación de nuevos objetos Arista que conectan los Nodos adyacentes
            vectorAristas[i][k] = new Arista(vectorNodos[i][k], vectorNodos[i+1][k], LONGITUD);
        }
    }
}

// Método para actualizar y dibujar los nodos y aristas
void actualizarYDibujarObjetos() {
    for (int k = 0; k < CANTIDAD; k++) {
        for (int i = 0; i < TAM-1; i++) {
            vectorAristas[i][k].update();
            vectorAristas[i][k].display();
        }
        
        for (int i = 1; i < TAM; i++) {
            vectorNodos[i][k].update();
            vectorNodos[i][k].display();
        }
    }
}