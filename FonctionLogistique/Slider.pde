/**
* classe qui affiche un slider et qui renvoie une valeur (Double) située entre minVal et maxVal, selon la position de la poignée
*/

class Slider {

  private Integer posI; // position horizontale du slider
  private Integer posJ; // position verticale du slider
  private Integer sizeI; // largeur du slider en pixels
  private Integer sizeJ; // hauteur du slider en pixels
  private Integer gapI; // ecart de détection en pixels pour permettre d'obtenir facilement la valeur min ou la valeur max quand la poignée arrive aux extrémités
  private float minVal; // minimum de la valeur à renvoyer
  private float maxVal; // maximum de la valeur à renvoyer
  private float startX; // valeur de départ de la valeur à renvoyer, positionne la poignée à la bonne position
  private Integer handleWidth;// largeur de la poignée en pixels
  private Integer handleHeight; // hauteur de la poignée en pixels
  private color sliderBgColor; // couleur de fond du slider
  private color handlesliderBgColor; // couleur de fond de la poignée
  private color strokeColor; // couleur du contour
  private color strokeColorOn; // couleur de contour allumé
  private color handleStkColor; // couleur du contour de la poignée
  private color sliderStkColor; // couleur du contour du slider
  private Double valToReturn; // valeur à retourner

/*
 * Constructeur
 */
  public Slider(Integer posI, Integer posJ, Integer sizeI, Integer sizeJ, Integer handleWidth, float minVal, float maxVal, float startX,
    color sliderBgColor, color handlesliderBgColor, color strokeColor, color strokeColorOn) {
    this.posI = posI;
    this.posJ = posJ;
    this.sizeI = sizeI;
    this.sizeJ = sizeJ;
    this.gapI = 5;
    this.handleWidth = handleWidth;
    this.minVal = minVal;
    this.maxVal = maxVal;
    this.startX = startX;
    this.handleHeight = sizeJ + 20;
    this.sliderBgColor = sliderBgColor;
    this.handlesliderBgColor = handlesliderBgColor;
    this.strokeColor = strokeColor;
    this.strokeColorOn = strokeColorOn;
  }

  public void init() {
    this.valToReturn = (double) this.startX;
    this.handleStkColor = this.strokeColor;
    this.sliderStkColor = this.strokeColor;
  }

  public Double run() {
    // dessin du slider
    strokeWeight(1);
    stroke(this.sliderStkColor);
    fill(this.sliderBgColor);
    rect(this.posI, this.posJ, this.sizeI, this.sizeJ, 8);
    // calcul de la position de la poignée
    float handlePosI = map(this.valToReturn.floatValue(), this.minVal, this.maxVal, this.posI, this.posI + this.sizeI);
    // dessin de la poignée
    stroke(this.handleStkColor);
    fill(this.handlesliderBgColor);
    rect(handlePosI - this.handleWidth/2, this.posJ - (this.handleHeight - this.sizeJ)/2, this.handleWidth, this.handleHeight, 6);
    
    // gestion de la souris
    if (mouseX > (this.posI - this.gapI) && mouseX < (this.posI + this.sizeI + this.gapI)) {
      if (mouseY > this.posJ && mouseY < this.posJ + this.sizeJ) {
        this.sliderStkColor = this.strokeColorOn;
        this.handleStkColor = this.strokeColorOn;
        if (mousePressed) {
          this.valToReturn = (double) map(mouseX, this.posI, this.posI + this.sizeI, this.minVal, this.maxVal);
          if(this.valToReturn < this.minVal) {
            this.valToReturn = (double) this.minVal;
          } else if(this.valToReturn > this.maxVal) {
            this.valToReturn = (double) this.maxVal;
          }
          this.handleStkColor = this.strokeColorOn;
          this.sliderStkColor = this.strokeColor;
        }
      } else {
        this.sliderStkColor = this.strokeColor;
        this.handleStkColor = this.strokeColor;
      }
    }
    return valToReturn;
  }
}
