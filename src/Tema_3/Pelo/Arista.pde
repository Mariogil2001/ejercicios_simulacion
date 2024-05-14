// Definición de la clase Arista
class Arista{ 
    // Declaración de variables
    PVector vectorAncho;  // Vector que representa el ancho de la arista
    float longitud;  // Longitud de la arista
    float energiaPotencialElastica;  // Constante de resorte y energía potencial elástica
    float elongacion = 0;  // Elongación de la arista
    
    // Fuerzas aplicadas en los nodos nodoInicial y nodoFinal
    PVector fuerzaNodoInicial = new PVector(0.0, 0.0);
    PVector fuerzaNodoFinal = new PVector(0.0, 0.0);
    
    // Nodos nodoInicial y nodoFinal que la arista conecta
    Nodo _nodoInicial;
    Nodo _nodoFinal;

    // Constructor de la clase Arista
    Arista(Nodo nodoInicial, Nodo nodoFinal, int longitudInicial) {
        _nodoInicial = nodoInicial;  // Inicializa el nodo nodoInicial
        _nodoFinal = nodoFinal;  // Inicializa el nodo nodoFinal
        longitud = longitudInicial;  // Inicializa la longitud de la arista
    } 

    // Método para actualizar la arista
    void update(){  
        // Calcula el ancho de la arista como la diferencia de las posiciones de los nodos
        vectorAncho = PVector.sub(_nodoFinal.posicion, _nodoInicial.posicion);
        // Calcula la elongación como la magnitud del ancho menos la longitud de la arista
        elongacion = vectorAncho.mag() - longitud;
        // Normaliza el ancho para obtener un vector unitario
        vectorAncho.normalize();
        // Calcula la energía potencial elástica
        energiaPotencialElastica = -k * elongacion;
        // Calcula las fuerzas aplicadas en los nodos nodoInicial y nodoFinal
        fuerzaNodoInicial = PVector.mult(vectorAncho, -energiaPotencialElastica);
        fuerzaNodoFinal = PVector.mult(vectorAncho, energiaPotencialElastica);
        
        // Aplica la amortiguación a las fuerzas
        fuerzaNodoInicial = PVector.sub(fuerzaNodoInicial, PVector.mult(_nodoInicial.velocidad, AMORTIGUACION));
        fuerzaNodoFinal = PVector.sub(fuerzaNodoFinal, PVector.mult(_nodoFinal.velocidad, AMORTIGUACION));
        
        // Aplica las fuerzas a los nodos nodoInicial y nodoFinal
        _nodoInicial.aplicarFuerza(fuerzaNodoInicial);
        _nodoFinal.aplicarFuerza(fuerzaNodoFinal);
    }

    // Método para visualizar la arista
    void display() {
        // Define el grosor y el color de la línea
        strokeWeight(1);
        stroke(COLOR_PELO);
        // Dibuja una línea entre los nodos nodoInicial y nodoFinal
        line(_nodoInicial.posicion.x, _nodoInicial.posicion.y, _nodoFinal.posicion.x, _nodoFinal.posicion.y);
        

    }
}