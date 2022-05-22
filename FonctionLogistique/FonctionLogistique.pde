private final color BG_COLOR = color(0, 0, 0); // couleur du fond de la fenêtre
private final Integer SIZE_I = 1800; // taille horizontale de la fenêtre en pixels
private final Integer SIZE_J = 1200; // taille verticale de la fenêtre en pixels
private Application app; // objet Application

public void settings() {
 app = new Application(SIZE_I, SIZE_J, BG_COLOR);
 app.init();
}

public void draw() {
 app.run();
}
