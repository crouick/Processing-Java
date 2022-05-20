private final color BACKGROUND_COLOR = color(25, 25, 25);
private final Integer SIZE_I = 1200; // largeur de la fenêtre en pixels
private final Integer SIZE_J = 1200; // hauteur de la fenêtre en pixels

//private Application app = new Application(SIZE_I, SIZE_J);


private Double angle = (double) 0.0; // angle de rotation de la scène
private Double agr = (double) 1.0; // taux d'agrandissement/réduction
private Double Tx = (double) 0.0, Ty = (double) 0.0; // coordonnées de la translation
private Point trans = new Point(Tx, Ty); // "vecteur" de la translation

private Double limitModule = (double) 2.0; // rayon d'échappement de la fractale
private JuliaFractal fractal; // objet de la fractale choisie
private Integer tabFractalSize = 15; // nombre de fractales pré-engistrées
private JuliaFractal[] tabFractal = new JuliaFractal[tabFractalSize]; // tableau des fractales enregistrées
private Integer fractalCount = 0; // indice de la fractale choisie

private Double minX = (double) -1.0; // minimum des x (variables intermédiaires à ne pas modifier)
private Double rangeX = (double) 2.0; // domaine des x (variables intermédiaires à ne pas modifier)
private Double rangeY = (double) rangeX*SIZE_J/SIZE_I; // domaine des y (variables intermédiaires à ne pas modifier)
private Double minY = (double) -rangeY / 2; // minimum des y (variables intermédiaires à ne pas modifier)
private Scene currentScene = new Scene(minX, minY, rangeX, rangeY, trans, angle, agr); // objet scene (variables intermédiaires à ne pas modifier)

private Point X1 = new Point((double) - 100.0, (double) 0.0); // limite x min des axes et quadriallages
private Point X2 = new Point((double) 100.0, (double) 0.0); // limite x max des axes et quadriallages

private Point Y1 = new Point((double) 0.0, (double) - 100.0); // limite y min des axes et quadriallages
private Point Y2 = new Point((double) 0.0, (double) 100.0); // limite y max des axes et quadriallages

private Boolean displayText = false; // booleen qui commande l'affichage ou non des textes
private Boolean displayMenu = true; // booleen qui commande l'affichage ou non du menu
private Boolean displayAxes = true; // booleen qui commande l'affichage des axes et du quadrillage
private Boolean isAxeXDrawable = true; // booleen qui indique si l'axes des x est dans la zone affichable
private Boolean isAxeYDrawable = true; // booleen qui indique si l'axes des y est dans la zone affichable
private Boolean drawFractal = true; // booleen qui commande l'affichage de la fractale


public void settings() {
  size(SIZE_I, SIZE_J, P2D);
  //app.init();
  
  tabFractal[0] = new JuliaFractal(new ComplexNb("Cart", (double) -0.4, (double) -0.59), limitModule, 150);
  tabFractal[1] = new JuliaFractal(new ComplexNb("Cart", (double) 0.355534, (double) -0.337292), limitModule, 1000);
  tabFractal[2] = new JuliaFractal(new ComplexNb("Cart", (double) -0.4, (double) -0.59), limitModule, 100);
  tabFractal[3] = new JuliaFractal(new ComplexNb("Cart", (double) -0.54, (double) 0.54), limitModule, 100);
  tabFractal[4] = new JuliaFractal(new ComplexNb("Cart", (double) 0.355, (double) 0.355), limitModule, 100);
  tabFractal[5] = new JuliaFractal(new ComplexNb("Cart", (double) -0.7, (double) 0.27015), limitModule, 300);
  tabFractal[6] = new JuliaFractal(new ComplexNb("Cart", (double) 0.285, (double) 0.01), limitModule, 75);
  tabFractal[7] = new JuliaFractal(new ComplexNb("Cart", (double) -1.417022285618, (double) 0.0099534), limitModule, 20);
  tabFractal[8] = new JuliaFractal(new ComplexNb("Cart", (double) -0.038088, (double) 0.9754633), limitModule, 20);
  tabFractal[9] = new JuliaFractal(new ComplexNb("Cart", (double) 0.285, (double) 0.013 ), limitModule, 200);
  tabFractal[10] = new JuliaFractal(new ComplexNb("Cart", (double) -0.4, (double) 0.6 ), limitModule, 100);
  tabFractal[11] = new JuliaFractal(new ComplexNb("Cart", (double) -0.8, (double) 0.156 ), limitModule, 150);
  tabFractal[12] = new JuliaFractal(new ComplexNb("Cart", (double) 0.0, (double) 0.8), limitModule, 25);
  tabFractal[13] = new JuliaFractal(new ComplexNb("Cart", (double) 0.3, (double) 0.5), limitModule, 50);
  tabFractal[14] = new JuliaFractal(new ComplexNb("Cart", (double) -0.8, (double) 0.0), limitModule, 200);
  
}

public void draw() {
  background(BACKGROUND_COLOR);
  //app.run();
  
  fractal = tabFractal[fractalCount];
  if (drawFractal) {
    drawFractal(currentScene, fractal);
  }

  if (displayAxes) {
    displayAxes(currentScene);
  }

  if (displayText) {
    Pixel pixMin = new Pixel(0, 0);
    Point pointMin = calcPointFromPix(pixMin, currentScene);
    Pixel pixMax = new Pixel(SIZE_I - 1, SIZE_J - 1);
    Point pointMax = calcPointFromPix(pixMax, currentScene);
    displayText(pointMin.getX(), pointMin.getY(), pointMax.getX(), pointMax.getY(), fractal, fractalCount, currentScene);
  }

  if (displayMenu) {
    displayMenu();
  }
  
}

/*
 * Procédure de dessin de la fractale
 * double boucle sur les pixels de la fenêtre et calcul du point(x,y) correspondant
 * affectation de la couleur du pixel du tableau "pixels" de la fenêtre avec la couleur
 * calculée par la fonction "calcColorFromJuliaFractal"
 *
 * @param Scene currenScene : objet scene contenant les paramétres de la scène
 * @param JuliaFractal fractal : objet contenant les paramètres de la fractale (seed c, seuil du module
 * et le nombre d'itération maximum de la boucle de calcul de la fractale
 */
public void drawFractal(Scene currentScene, JuliaFractal fractal) {
  Pixel pix = new Pixel(0, 0);
  loadPixels();
  for (int i=0; i<SIZE_I; i++) {
    for (int j=0; j<SIZE_J; j++) {
      pix.setI(i);
      pix.setJ(j);
      Point point = calcPointFromPix(pix, currentScene);
      ComplexNb z = new ComplexNb("Cart", point.getX(), point.getY());
      pixels[pix.getI()+pix.getJToDraw(SIZE_J)*SIZE_I] = calcColorFromJuliaFractal(z, fractal, 3, 2);
    }
  }
  updatePixels();
}

/*
 * Fontion qui renvoie une couleur en fonction du nombre complexe z après traitement selon les
 * paramètres de la fractale
 *
 * @param Complex z : nombre complexe à traiter
 * @param JuliaFractal fractal : objet contenant les paramètres de la fractale (seed c, seuil du module
 * et le nombre d'itération maximum de la boucle de calcul de la fractale
 * @return color colorToReturn : couleur calculée par le traitement de z selon fractal
 */
public color calcColorFromJuliaFractal(ComplexNb z, JuliaFractal fractal, Integer gradientStart, Integer gradientRange) { // ComplexNb c, Double limitModule, Integer maxIteration
  color colorToReturn = color(0, 0, 0);
  ComplexNb c = fractal.getSeed();
  Double limitModule = fractal.getLimit();
  Integer iteration = fractal.getMaxIt();
  Double xz = z.getReal();
  Double yz = z.getImag();
  Double xc = c.getReal();
  Double yc = c.getImag();
  //Double module = (double) Math.sqrt(xz * xz + yz * yz);
  Double module = z.getMod();

  while ((module < limitModule) && (iteration > 0)) {
    Double tmpX = (double) (xz * xz - yz * yz + xc);
    yz = (double) (2 * xz * yz + yc);
    xz = (double) tmpX;
    module = (double) Math.sqrt(xz * xz + yz * yz);
    iteration--;
  }
  if (iteration > 0) {
    colorToReturn = color(0, 0, 0);
  } else {
    colorToReturn = calculateRVB(module, limitModule, gradientStart, gradientRange);
  }
  return colorToReturn;
}

/*
 * Procédure qui affiche les informations
 */
private void displayText(Double minX, Double minY, Double maxX, Double maxY, JuliaFractal fractal, Integer fractalCount, Scene currentScene) {
  fill(0, 0, 0);
  rect(0, 0, SIZE_I - 1, 340);

  fill(255, 255, 255);
  textSize(32);

  text("Min. x : " + minX + " / Max. x : " + maxX, 20, 40);
  text("Min. y : " + minY + " / Max. y : " + maxY, 20, 80);
  text("Range x : " + (maxX - minX) + " / Range y : " + (maxY - minY), 20, 120);
  text("Seuil : " + fractal.getLimit() + " / Nb itérat° : " + fractal.getMaxIt(), 20, 160);
  text("Xc : " + fractal.getSeed().getReal() + " / Yc : " + fractal.getSeed().getImag(), 20, 200);
  text("Numéro de la fractale : " + (fractalCount + 1), 20, 240);
  text("Tx : " + currentScene.getTrans().getX() + " / Ty : " + currentScene.getTrans().getY(), 20, 280);
  text("Agr : " + currentScene.getAgr() + " / Angle : " + currentScene.getAngle() + "°", 20, 320);
}

/*
 * Procédure qui affiche le menu
 */
private void displayMenu() {
  fill(0, 0, 0);
  rect(0, SIZE_J - 80, SIZE_I - 1, SIZE_J - 1);

  fill(255, 255, 255);
  textSize(16);
  text("Menu : ", 20, SIZE_J - 60);
  text("[Flèches] : déplacement | [A/Z] : zoom -/+ | [W/X] : rotation -/+ | [S/D] : fractale précedente/suivante", 20, SIZE_J - 40);
  text("[T] : Afficher/Masquer les textes | [Y] : Afficher/Masquer les repères | [F] : Afficher/Masquer la fractale | [M] : Afficher/Masquer le menu | [Q] : quitter", 20, SIZE_J - 20);
}

/*
 * Procédure qui dessine les axes, la quadrillage, l'origine des axes et les vecteurs unitaires
 *
 * @param Scene currenScene : objet scene contenant les paramétres de la scène
 */
private void displayAxes(Scene currentScene) {
  // dessin de l'origine du repère x,y
  Point pointOrig = new Point((double) 0.0, (double) 0.0);
  Pixel pixOrig = calcPixelFromPoint(pointOrig, currentScene);
  fill(255, 255, 255);
  if ((pixOrig.getI() >= 0 && pixOrig.getI() <= (SIZE_I - 1)) && (pixOrig.getJ() >= 0 && pixOrig.getJ() <= (SIZE_J - 1))) {
    circle(pixOrig.getI(), pixOrig.getJToDraw(SIZE_J), 10);
  }

  stroke(255, 255, 255);
  strokeWeight(1.99);

  // dessin de l'axe des x si visible
  Pixel I1 = calcPixelFromPoint(X1, currentScene);
  Pixel I2 = calcPixelFromPoint(X2, currentScene);
  if (isAxeXDrawable) {
    line(I1.getI(), I1.getJToDraw(SIZE_J), I2.getI(), I2.getJToDraw(SIZE_J));
  }

  // dessin de l'axe des y si visible
  Pixel J1 = calcPixelFromPoint(Y1, currentScene);
  Pixel J2 = calcPixelFromPoint(Y2, currentScene);
  if (isAxeYDrawable) {
    line(J1.getI(), J1.getJToDraw(SIZE_J), J2.getI(), J2.getJToDraw(SIZE_J));
  }

  // dessin de l'extrémité du vecteur unitaire des x
  Point Pi = new Point((double) 1.0, (double) 0.0);
  Pixel PixI = calcPixelFromPoint(Pi, currentScene);
  circle(PixI.getI(), PixI.getJToDraw(SIZE_J), 5);

  // dessin de l'extrémité du vecteur unitaire des y
  Point Pj = new Point((double) 0.0, (double) 1.0);
  Pixel PixJ = calcPixelFromPoint(Pj, currentScene);
  circle(PixJ.getI(), PixJ.getJToDraw(SIZE_J), 5);

  // dessin du quadrillage en fonction de la largeur des x visible idem pour y
  Double distX = calcDistX(currentScene);
  Double distY = calcDistY(currentScene);
  strokeWeight(0.5);

  for (int k=2; k>=-3; k--) {
    Double step = Math.pow(10.0, k);
    if ((distX >= step) && (distX < 20*step)) {
      drawLinesY(step, currentScene);
    }
    if ((distY >= step) && (distY < 20*step)) {
      drawLinesX(step, currentScene);
    }
  }

  // affichage de "(0,0)" près du point origine
  noStroke();
  fill(255, 255, 255);
  textSize(18);
  text("(0,0)", pixOrig.getI() + 10, pixOrig.getJToDraw(SIZE_J) - 10);
}


/*
 * Fonction qui renvoie la largeur sur x de la fenêtre
 *
 * @param Scene currenScene : objet scene contenant les paramétres de la scène
 * @return Double dist : largeur
 */
private Double calcDistX(Scene currentScene) {
  Pixel pixStart = new Pixel (0, 0);
  Point start = calcPointFromPix(pixStart, currentScene);
  Pixel pixEnd = new Pixel (SIZE_I - 1, 0);
  Point end = calcPointFromPix(pixEnd, currentScene);
  Double dist = start.calcDist(end) / Math.cos(degreeToRad(currentScene.getAngle()));
  return dist;
}

 /*
  * Fonction qui renvoie la hauteur sur y de la fenêtre
  *
  * @param Scene currenScene : objet scene contenant les paramétres de la scène
  * @return Double dist : hauteur
  */
private Double calcDistY(Scene currentScene) {
  Pixel pixStart = new Pixel (0, 0);
  Point start = calcPointFromPix(pixStart, currentScene);
  Pixel pixEnd = new Pixel (0, SIZE_J - 1);
  Point end = calcPointFromPix(pixEnd, currentScene);
  Double dist = start.calcDist(end) / Math.cos(degreeToRad(currentScene.getAngle()));
  return dist;
}


/*
 * Procédure qui dessine des lignes du quadrillage parallèles à l'axe des y espacées de stepX
 *
 * @param Double stepX : écart entre les lignes du quadrillage
 * @param Scene currenScene : objet scene contenant les paramétres de la scène
 */
// TODO ajouter affichage des valeur de x du quadrillage (en bas de l'ecran)
private void drawLinesY(Double stepX, Scene currentScene) {
  for (Double x = (double) -100.0; x <= (double) 100.0; x += stepX) {
    Point pt1 = new Point(x, (double) -100.0);
    Pixel pix1 = calcPixelFromPoint(pt1, currentScene);
    Point pt2 = new Point(x, (double) 100.0);
    Pixel pix2 = calcPixelFromPoint(pt2, currentScene);
    line(pix1.getI(), pix1.getJToDraw(SIZE_J), pix2.getI(), pix2.getJToDraw(SIZE_J));
  }
}

/*
 * Procédure qui dessine des lignes du quadrillage parallèles à l'axe des x espacées de stepY
 *
 * @param Double stepY : écart entre les lignes du quadrillage
 * @param Scene currenScene : objet scene contenant les paramétres de la scène
 */
private void drawLinesX(Double stepY, Scene currentScene) {
  for (Double y = (double) -100.0; y <= (double) 100.0; y += (double) stepY) {
    Point pt1 = new Point((double) -100.0, y);
    Pixel pix1 = calcPixelFromPoint(pt1, currentScene);
    Point pt2 = new Point((double) 100.0, y);
    Pixel pix2 = calcPixelFromPoint(pt2, currentScene);
    line(pix1.getI(), pix1.getJToDraw(SIZE_J), pix2.getI(), pix2.getJToDraw(SIZE_J));
  }
}

/*
 * Fonction qui renvoie le point(x,y) correspondant au pixel(i,j) de la fenêtre
 *
 * @param Pixel pixel : pixel a convertir en coordonnées x,y
 * @param Point trans : "vecteur" de la tranlation
 * @param Double age : taux d'agrandissement/réduction
 * @param Double angle : angle en degré de la rotation
 * @param Scene currenScene : objet scene contenant les paramétres de la scène
 * @return Point
 */
public Point calcPointFromPix(Pixel pixel, Scene currentScene) {
  Double x = currentScene.getMinX() + currentScene.calcStepX(SIZE_I)*pixel.getI();
  Double y = currentScene.getMinY() + currentScene.calcStepY(SIZE_J)*pixel.getJ();
  return calcDir(new Point(x, y), currentScene);
}

/*
 * Fonction qui renvoie le pixel(i,j)  de la fenêtre correspondant au point(x,y)
 *
 * @param Point start : point à convertir en pixel
 * @param Point trans : "vecteur" de la tranlation
 * @param Double age : taux d'agrandissement/réduction
 * @param Double angle : angle en degré de la rotation
 * @param Scene currenScene : objet scene contenant les paramétres de la scène
 à @return Pixel
 */
public Pixel calcPixelFromPoint(Point start, Scene currentScene) {
  Point end = calcInv(start, currentScene);
  Double x = end.getX();
  Double y = end.getY();
  Integer i = (int) ((x - currentScene.getMinX())*SIZE_I/currentScene.getRangeX());
  Integer j = (int) ((y - currentScene.getMinY())*SIZE_J/currentScene.getRangeY());
  return new Pixel(i, j);
}

/*
 * Fonction qui renvoie le point obtenu après transformation du point start
 *
 * Transformation : calcul de l'agrandissement/réduction, de la translation
 * et la rotation du point start
 * @param Point start : point à transformer
 * @param Scene currentScene : objet contenant les paramètres de la transformation
 * @return Point
 */
public Point calcDir(Point start, Scene currentScene) {
  Point toReturn = new Point((double) 0.0, (double) 0.0);
  toReturn = calcRotDir(calcTransDir(calcAgrDir(start, currentScene), currentScene), currentScene);
  return toReturn;
}

/*
 * Fonction qui renvoie le point obtenu après transformation inverse du point start
 * Transformation : calcul de la rotation, de la translation et de l'agrandissement/réduction
 * du point start
 *
 * @param Point start : point à transformer
 * @param Scene currentScene : objet contenant les paramètres de la transformation
 * @return Point
 */
public Point calcInv(Point start, Scene currentScene) {
  Point toReturn = new Point((double) 0.0, (double) 0.0);
  toReturn = calcAgrInv(calcTransInv(calcRotInv(start, currentScene), currentScene), currentScene);
  return toReturn;
}

/*
 * Fonction qui renvoie le point obtenu après agrandissement/réduction du point start
 *
 * @param Point start : point à transformer
 * @param Scene currentScene : objet contenant les paramètres de la transformation
 * @return Point
 */
public Point calcAgrDir(Point start, Scene currentScene) {
  Point middle = currentScene.calcMiddle();
  Double x = middle.getX() + (start.getX() - middle.getX())*currentScene.getAgr();
  Double y = middle.getY() + (start.getY() - middle.getY())*currentScene.getAgr();
  return new Point(x, y);
}

/*
 * Fonction qui renvoie le point obtenu après l'inverse de l'agrandissement/réduction du point start
 *
 * @param Point start : point à transformer
 * @param Scene currentScene : objet contenant les paramètres de la transformation
 * @return Point
 */
public Point calcAgrInv(Point start, Scene currentScene) {
  Point middle = currentScene.calcMiddle();
  Double x = middle.getX() + (start.getX() - middle.getX())/currentScene.getAgr();
  Double y = middle.getY() + (start.getY() - middle.getY())/currentScene.getAgr();
  return new Point(x, y);
}

/*
 * Fonction qui renvoie le point obtenu après translation du point start
 *
 * @param Point start : point à transformer
 * @param Scene currentScene : objet contenant les paramètres de la transformation
 * @return Point
 */
public Point calcTransDir(Point start, Scene currentScene) {
  return new Point(start.getX() + currentScene.getTrans().getX(), start.getY() + currentScene.getTrans().getY());
}

/*
 * Fonction qui renvoie le point obtenu après translation inverse du point start
 *
 * @param Point start : point à transformer
 * @param Scene currentScene : objet contenant les paramètres de la transformation
 * @return Point
 */
public Point calcTransInv(Point start, Scene currentScene) {
  return new Point(start.getX() - currentScene.getTrans().getX(), start.getY() - currentScene.getTrans().getY());
}

/*
 * Fonction qui renvoie le point obtenu après rotation du point start
 *
 * @param Point start : point à transformer
 * @param Scene currentScene : objet contenant les paramètres de la transformation
 * @return Point
 */
public Point calcRotDir(Point start, Scene currentScene) {
  Point middle = currentScene.calcMiddle();
  Double x = middle.getX() + (start.getX() - middle.getX())*Math.cos(degreeToRad(currentScene.getAngle())) -  (start.getY() - middle.getY())*Math.sin(degreeToRad(currentScene.getAngle()));
  Double y = middle.getY() + (start.getX() - middle.getX())*Math.sin(degreeToRad(currentScene.getAngle())) +  (start.getY() - middle.getY())*Math.cos(degreeToRad(currentScene.getAngle()));
  return new Point(x, y);
}

/*
 * Fonction qui renvoie le point obtenu après rotation inverse du point start
 *
 * @param Point start : point à transformer
 * @param Scene currentScene : objet contenant les paramètres de la transformation
 * @return Point
 */
public Point calcRotInv(Point start, Scene currentScene) {
  Point middle = currentScene.calcMiddle();
  Double x = middle.getX() + (start.getX() - middle.getX())*Math.cos(degreeToRad(currentScene.getAngle())) +  (start.getY() - middle.getY())*Math.sin(degreeToRad(currentScene.getAngle()));
  Double y = middle.getY() - (start.getX() - middle.getX())*Math.sin(degreeToRad(currentScene.getAngle())) +  (start.getY() - middle.getY())*Math.cos(degreeToRad(currentScene.getAngle()));
  return new Point(x, y);
}
