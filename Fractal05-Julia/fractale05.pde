private final color BACKGROUND_COLOR = color(25, 25, 25);
private final Integer SIZE_I = 1200; // largeur de la fenêtre en pixels
private final Integer SIZE_J = 1200; // hauteur de la fenêtre en pixels
private Application app = new Application(SIZE_I, SIZE_J);

public void settings() {
  size(SIZE_I, SIZE_J, P2D);
  app.init();
}

public void draw() {
  background(BACKGROUND_COLOR);
  app.run();
}
