class Splash {
    ArrayList<PVector> drops;
    PVector pos;
    float lifespan;

    Splash(PVector position) {
        drops = new ArrayList<PVector>();
        pos = position.copy();
        lifespan = 128;

        // Generar gotas
        for (int i = 0; i < 100; i++) {
            PVector drop = PVector.random2D();
            drop.y = abs(drop.y) * -2; // Asegura que la dirección es hacia arriba
            drop.mult(random(20, 50));
            drops.add(drop);
        }
    }

    void run() {
        update();
        display();
    }

    void update() {
        lifespan -= 2;
        for (PVector drop : drops) {
            drop.add(PVector.mult(drop, 0.015)); // Las gotas se alejan del centro
        }
    }

    void display() {
        pushStyle();
        stroke(142, 202, 230, lifespan);
        for (PVector drop : drops) {
            // Dibuja un círculo con un tamaño de 5
            ellipse(pos.x + drop.x, pos.y + drop.y, 5, 5);
        }
        popStyle();
    }

    boolean isDead() {
        return lifespan < 0;
    }
}