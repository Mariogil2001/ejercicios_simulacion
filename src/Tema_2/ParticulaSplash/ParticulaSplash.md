# Partícula Splash ♨️

A partir del ejercicio de la Partícula Flotante, he creado una clase Splash donde cuando por primera vez la partícula colisiona con el agua se generan 100 partículas de manera aleatoria sobre el eje y alejandose del centro de la partícula con un tiempo de vida.
```java
        // Generar gotas
        for (int i = 0; i < 100; i++) {
            PVector drop = PVector.random2D();
            drop.y = abs(drop.y) * -2; // Asegura que la dirección es hacia arriba
            drop.mult(random(20, 50));
            drops.add(drop);
        }
```