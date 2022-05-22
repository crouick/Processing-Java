/*
 * Classe de l'application.
 * formule : U(n+1) = k x U(n) x ( 1 - U(n) ) avec U(0) et k donnés
 */
class Application {
  private final Integer sizeI; // largeur de la fenêtre en pixels
  private final Integer sizeJ; // hauteur de la fenêtre en pixels
  private final color bgColor; // couleur du fond de la fenêtre
  private Integer stepI = 20; // ecart entre les itérations (axe horizontal) en pixels
  private Integer nbIt = 1000 + 1; // nombre d'itérations et d'éléments dans me tableau
  private Integer startIt; // valeur min des itérations (axe horizontal) pour l'affichage
  Double xStart = (double) 0.33; // U(0) valeur initiale de la suite
  Double coef = (double) 3.1; // coefficient k de la suite
  Double[] tabX; // tableau contenant les valeurs de la suite pour chaque itération
  Slider sliderX0, sliderCoef, sliderStartIt; // objets Slider qui déterminent respectivement U(0) (xStart), la constante k (coef) et la valeur min des itérations à afficher (startIt)

/*
 * Constructeur
 */
  public Application(Integer sizeI, Integer sizeJ, color bgColor) {
    this.sizeI = sizeI;
    this.sizeJ = sizeJ;
    this.bgColor = bgColor;
  }

/*
 * Initialisation des objets, des couleurs, etc.
 */
  public void init() {
    size(SIZE_I, SIZE_J);
    color sliderBgColor = color(20, 20, 20);
    color handleBgColor = color(80, 80, 80);
    color stkColor = color(120, 120, 120);
    color stkColorOn = color(255, 200, 0);
    this.sliderX0 = new Slider(100, this.sizeJ - 130, 780, 30, 10, 0.0, 1.0, this.xStart.floatValue(), sliderBgColor, handleBgColor, stkColor, stkColorOn);
    this.sliderX0.init();
    this.sliderCoef = new Slider(920, this.sizeJ - 130, 780, 30, 10, 1.0, 4.0, this.coef.floatValue(), sliderBgColor, handleBgColor, stkColor, stkColorOn);
    this.sliderCoef.init();
    Integer nbItDisplay = 1 + (this.sizeI - 200)/this.stepI;
    this.startIt = 0;
    this.sliderStartIt = new Slider(100, this.sizeJ - 200, 1600, 30, 10, 0.0, (float) (this.nbIt - nbItDisplay), (float) this.startIt, sliderBgColor, handleBgColor, stkColor, stkColorOn);
    this.sliderStartIt.init();
    this.tabX = new Double[nbIt];
  }

/*
 * lance l'application
 */
  public void run() {
    background(bgColor); 
    drawAxes(this.sizeI, this.sizeJ, this.startIt, this.stepI);
    displayMenu(this.sizeI);
    fillTabX(this.tabX, this.xStart, this.coef, this.nbIt);
    drawTabX(this.tabX, this.xStart, this.startIt, this.sizeI, this.stepI, this.sizeJ);
    this.xStart = this.sliderX0.run();
    this.coef = this.sliderCoef.run();  
    Double value = this.sliderStartIt.run();
    this.startIt = (int) Math.round(value);
    displayText(this.xStart, this.coef, this.sizeJ, this.nbIt);
  }

/*
 * Procédure qui calcule et rempli le tableau (en paramètre) avec les valeurs successives de la suite
 * formule : U(n+1) = k x U(n) x ( 1 - U(n) ) avec U(0) et k donnés
 *
 * @param Double[] tabX : tableau à remplir
 * @param Double xStart : valeur de départ de la suite U(0)
 * @param Double coef : constante k de la suite
 * @param Integer nbIt : nombre d'éléments du tableau et nombre d'itérations de la boucle
 */
  public void fillTabX(Double[] tabX, Double xStart, Double coef, Integer nbIt) {
    tabX[0] = xStart;
    Double x= xStart;
    for (int i=1; i<(nbIt); i++) {
      x = coef*x*(1-x);
      tabX[i] = x;
    }
  }

/*
 * Procédure qui dessine une partie des valeurs du tableau (en paramètreà selon la valeur de départ des itérations affichables
 *
 * @param Double[] tabX : tableau à parcourir
 * @param Double xStart : U(0), sert à colorer les lignes
 * @param Integer startIt : valeur min des itérations affichées
 * @param Integer sizeI : largeur de la fenêtre en pixels
 * @param Integer stepI : écart entre deux itérations en pixels
 * @param Integer sizeJ : hauteur de la fenêtre en pixels
 */
  public void drawTabX(Double[] tabX, Double xStart, Integer startIt, Integer sizeI, Integer stepI, Integer sizeJ) {
    Integer rangeIt = (sizeI - 200)/stepI;
    for (int i=startIt; i<=(rangeIt + startIt); i++) {
      Double x = (double) tabX[i];
      color fillColor =  calculateRVB((1 - x), (double) 1.0, 1, 5);
      drawPoint(x, i - startIt, fillColor, stepI, sizeJ);
      if (i>startIt) {
        fillColor =  calculateRVB((1 - xStart), (double) 1.0, 1, 5);
        stroke(fillColor);
        strokeWeight(2);
        line(100 + (i-1-startIt)*stepI, getJFromX(tabX[i-1], sizeJ), 100 + (i-startIt)*stepI, getJFromX(tabX[i], sizeJ));
        strokeWeight(0.5);
        stroke(color(100, 100, 100));
        line(100 + (i-startIt)*stepI, getJFromX(tabX[i], sizeJ), 100 + (i-startIt)*stepI, getJFromX((double) 0.0, sizeJ));
      }
    }
  }

/*
 * Procédure qui dessine un cercle coloré de rayon 15 pixels selon les paramètres
 *
 * @param Double x : valeur à afficher (0 <= x <= 1) sur l'axe vertical
 * @param Integer n : indice de l'itération à afficher sur l'axe horizontal
 * @param color fillColor : couleur du cercle
 * @param Integer stepI : écart en pixels entre deux itérations (axe horizontal)
 * @param Integer sizeJ : hauteur de la fenêtre en pixels
 */
  public void drawPoint(Double x, Integer n, color fillColor, Integer stepI, Integer sizeJ) {
    Pixel pix = new Pixel (0, 0);
    pix.setI(100 + n*stepI);
    pix.setJ(getJFromX(x, sizeJ));
    fill(fillColor);
    strokeWeight(2);
    stroke(color(255, 255, 255));
    circle(pix.getI(), pix.getJ(), 15);
  }

/*
 * Fonction qui renvoie la position verticale en pixels correspondant à x passé en paramètre
 *
 * @param Double x : valeur afficher (0 <= x <= 1) sur l'axe vertical
 * @param Integer sizeJ : hauteur de la fenêtre en pixels
 *
 * @return Integer : position verticale correspondant à x
 */
  public Integer getJFromX(Double x, Integer sizeJ) {
    Integer j = (int) (100 + (sizeJ - 400)*(1 - x));
    return j;
  }
  
/*
 * Fonction qui renvoie la valeur de x (0 <= x <= 1) correspondant à la position verticale j en pixels passé en paramètre
 *
 * @param Integer j : position verticale du pixel
 * @param Integer sizeJ : hauteur de la fenêtre en pixels
 *
 * @return Double : valeur de x (0 <= x <= 1) correspondant à la position verticale j
 */
  public Double getXfromJ(Integer j, Integer sizeJ) {
    Double x = (double) (j - sizeJ - 300)/(400 - sizeJ);
   return (double) x; 
  }

/*
 * Procédure qui dessine les axes et leurs textes
 *
 * @param Integer sizeI : largeur de la fenêtre en pixels
 * @param Integer sizeJ : hauteur de la fenêtre en pixels
 * @param Integer startIt : valeur min des itérations affichées
 * @param Integer stepI : écart en pixels entre deux itérations (axe horizontal)
 */
  public void drawAxes(Integer sizeI, Integer sizeJ, Integer startIt, Integer stepI) {
    stroke(127, 127, 127);
    fill(0, 0, 0);
    strokeWeight(1);
    rect(0, 0, sizeI - 1, sizeJ - 1);
    line(0, sizeJ - 240, sizeI - 1, sizeJ - 240);
    strokeWeight(1);
    textSize(12);
    fill(255, 255, 255);
    line(100 - 15, getJFromX((double) 0.5, sizeJ), 100, getJFromX((double) 0.5, sizeJ));
    for(Double x = (double) 0.1; x <= (double) 1; x = x + (double) 0.1) {
        line(100 - 15, getJFromX(x, sizeJ), 100, getJFromX(x, sizeJ));
        text(nf(x.floatValue(), 1, 1), 100 - 35, getJFromX((double) x, sizeJ));
    }
    textSize(18);
    text("0", 100 - 35, sizeJ - 300 - 1);
    text("1", 100 - 35, 100);
    Integer count = 0;
    textSize(10);
    strokeWeight(2);
    textAlign(CENTER);
    for (int i = 100; i <= sizeI - 100; i = i + stepI) {
      line(i, sizeJ - 300 - 1, i, sizeJ - 300 - 1 + 5);
      text((count + startIt), i, sizeJ - 300 - 1 + 30);
      count++;
    }
    textAlign(LEFT);
    drawVertGradient(8, 1, 5, sizeJ);
    strokeWeight(3);
    stroke(255, 255, 255);
    line(100, 100, 100, sizeJ - 300 - 1 + 5);
    line(100 - 15, sizeJ - 300 - 1, sizeI - 100 - 1, sizeJ - 300 - 1);
    line(100 - 15, 100, 100, 100);
  }

/*
 * Procédure qui affiche les textes : u(0), k et la formule de la suite
 * formule : U(n+1) = k x U(n) x ( 1 - U(n) ) avec U(0) et k donnés
 *
 * @param Double xStart : U(0)
 * @param Double coef : constante k de la suite
 * @param Integer sizeJ : hauteur de la fenêtre en pixels
 * @param Integer nbIt : nombre d'éléments du tableau et nombre d'itérations de la boucle
 */
  public void displayText(Double xStart, Double coef, Integer sizeJ, Integer nbIt) {
    fill(255, 255, 255);
    textSize(36);
    text("U(0) : " + nf(xStart.floatValue(), 1, 3), 100, sizeJ - 40);
    text("constante : " + nf(coef.floatValue(), 1, 3), 920, sizeJ - 40);
    textSize(24);
    text("U(n+1) = " + nf(coef.floatValue(), 1, 3) + " x U(n) x ( 1 - U(n) ) avec U(0) = " + nf(xStart.floatValue(), 1, 3) 
    + " sur " + (nbIt - 1) + " itérations", 100, 60);
  }

/*
 * Procédure qui affiche le menu
 * [Q] : quitter
 * 
 * @param Integer sizeI : largeur de la fenêtre en pixels
 */
  public void displayMenu(Integer sizeI) {
    fill(255, 255, 255);
    textSize(24);
    text("[Q] : quitter", sizeI - 220, 60);
  }

/*
 * Dessine un dégradé de couleur vertical
 *
 * @param Integer thickness : épaisseur horizontale du dégradé
 * @param Integer start : détermine la couleur de début du dégradé dans l'arc en ciel
 * @param Integer range : détermine la zone de l'arc en ciel couverte par le dégradé
 * @param Integer sizeJ : hauteur de la fenêtre en pixels
 */
  public void drawVertGradient(Integer thickness, Integer start, Integer range, Integer sizeJ) {
    for (int j=0; j<sizeJ - 400; j++) {
      stroke(calculateRVB((double) j, (double) sizeJ - 400, start, range));
      line(100 - thickness, j + 100, 100, j + 100);
    }
  }
}
