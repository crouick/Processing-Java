private final color BG_COLOR = color(25, 25, 25);
private final Integer SIZE_I = 1800;
private final Integer SIZE_J = 1200;

private Application app;
//private Double k = (double) 4.0;

public void settings() {
 size(SIZE_I, SIZE_J); // , P2D
 app = new Application(SIZE_I, SIZE_J);
 app.init();
}

public void draw() {
 background(BG_COLOR); 
 app.run();
}
