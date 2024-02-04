# Ejercicio Movimiento Oscilatorio 🌔
## Enunciado
Animar el movimiento de una particula a velocidad _v_ sobre las 2 funciones osciladoras.

$$
y = 0.5sin(3x) + 0.5sin(3.5x)
$$


## Implementación
Se ha implementado de la siguiente manera en el codigo:
```java
  // Calcular las coordenadas x y y de la bola utilizando funciones trigonométricas
  x += v; // Incrementa la posición en x con la velocidad
  
  y = height/2 + 50* (0.5 * sin(3*x) + 0.5*sin(3.5*x)); // Mantiene la misma amplitud en y
```

He tenido que multiplicar por 50 la función, ya que sino no se apreciaba el cambio en la onda. Además se le suma _height/2_ para que empiece
centrada en la pantalla.
## Extra
A parte de esto, he añadido la visualización del trazado para que se observe de mejor manera la oscilación.

```java
ArrayList<PVector> trayectoria; // Arraylist para almacenar las coordenadas de la trayectoria
...
trayectoria.add(new PVector(x, y)); // Agregar las coordenadas a la trayectoria
...
void dibujarTrayectoria() {
  noFill();
  stroke(0,0,0); // Color rojo para la trayectoria
  beginShape();
  for (PVector punto : trayectoria) {
    vertex(punto.x, punto.y);
  }
  endShape();
}
```



![MockUP](MovimientoOscilatorio.png)
