# Ejercicio Montaña rusa 🎢
## Enunciado
Simular el movimiento de una partícula que se
mueve a tramos de velocidad (ej. con pendientes distintas en cada tramo y
velocidades en función de las pendientes).

Además añadir aceleración en los tramos.

## Velocidad constante en todo el intervalo
Formulas en las que me he basado para resolverlo:

$$
\begin{align*}
v_{media} =\frac{ \vartriangle x} {\vartriangle t} \\
x += v_{media} * \vartriangle t
\end{align*}
$$

Se ha implementado de la siguiente manera en el codigo:
```java
  if (p.dist(b) <= 1) {
    velAB = velBC; // Cuando alcanza B cambia de direccion hacia C
    println(velAB);
  }
  p.add(PVector.mult(velAB,dt)); // Para velocidad constante
```
Siendo **p** la **Particula** que se desplaza por el circuito y **velAB** siendo la **velocidad media** en el primer tramo.
## Aceleración constante en todo el intervalo
Formulas en las que me he basado para añadirle la aceleración en los tramos:

Para actualizar la velocidad:

$$
v = v_0 + a * \vartriangle t
$$

Para actualizar la posición se emplea la misma formula que con velocidad constante:

$$
x += v_{media} * \vartriangle t
$$

Para añadir aceleración en los tramos se ha implementado:
```java
// Actualizar la velocidad y posición según la aceleración en el tramo AB
  if (p.x < b.x) {
    velAB.add(PVector.mult(velAB.copy().normalize(), accAB * dt));
    p.add(PVector.mult(velAB, dt));
  }
  
  // Actualizar la velocidad y posición según la aceleración en el tramo BC
  if (p.x >= b.x && p.x < c.x) {
    velBC.add(PVector.mult(velBC.copy().normalize(), accBC * dt));
    p.add(PVector.mult(velBC, dt));
  }
```
