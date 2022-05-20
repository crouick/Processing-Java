/*
 * Classe représentant les paramètres d'une scene
 */
class Scene {
 private Double minX; // minimum des x (variable intermédiaire de valcul, à ne pas modifier
 private Double minY; // minimum des y (variable intermédiaire de valcul, à ne pas modifier
 private Double rangeX; // "largeur" des x (variable intermédiaire de valcul, à ne pas modifier
 private Double rangeY; // "largeur" des y (variable intermédiaire de valcul, à ne pas modifier
 private Point trans; // vecteur de la translation effectuée
 private Double angle; // angle en degré de la rotation effectuée
 private Double agr; // taux d'agrandissement/réduction effectué
 
 /*
  * Constructeur
  */
 public Scene(Double minX, Double minY, Double rangeX, Double rangeY, Point trans, Double angle, Double agr) { // , Point trans, Double angle, Double agr
  this.minX = minX;
  this.minY = minY;
  this.rangeX = rangeX;
  this.rangeY = rangeY;
  this.trans = trans;
  this.angle = angle;
  this.agr = agr;
  
 }
  
  public Double getMinX() {
   return this.minX; 
  }
  public Double getMinY() {
   return this.minY; 
  }
  public Double getRangeX() {
   return this.rangeX; 
  }
  public Double getRangeY() {
   return this.rangeY; 
  }
  public Point getTrans() {
   return this.trans; 
  }
  public Double getAngle() {
   return this.angle; 
  }
  public Double getAgr() {
   return this.agr; 
  }
  
  public void setMinX(Double minX) {
   this.minX = minX; 
  }
  public void setMinY(Double minY) {
   this.minY = minY; 
  }
  public void setRangeX(Double rangeX) {
   this.rangeX = rangeX; 
  }
  public void setRangeY(Double rangeY) {
   this.rangeY = rangeY; 
  }
  public void setTrans(Point trans) {
   this.trans = trans; 
  }
  public void setAngle(Double angle) {
   this.angle = angle; 
  }
  public void setAgr(Double agr) {
   this.agr = agr; 
  }
  
  public String toString() {
    return ("minX : " + this.minX + " minY : " + this.minY + " rangeX : " + this.rangeX + " rangeY : " 
    + this.rangeY); //  - " trans : " + trans.toString() + " angle : " + this.angle + " agr : " + this.agr
  }
  
  /*
   * Fonction qui renvoie le pas de la boucle sur l'axe des x en tenant compte de la largeur de la fenêtre
   *
   * @param Integer sizeX : taille horizontale de la fenêtre en pixels
   * @return Double : pas de la boucle sur l'axe des x
   */
  public Double calcStepX(Integer sizeX) {
   return (Double) (this.rangeX/sizeX);
  }
  
  /*
   * Fonction qui renvoie le pas de la boucle sur l'axe des y en tenant compte de la hauteur de la fenêtre
   *
   * @param Integer sizeY : taille verticale de la fenêtre en pixels
   * @return Double : pas de la boucle sur l'axe des y
   */
  public Double calcStepY(Integer sizeY) {
   return (Double) (this.rangeY/sizeY);
  }
  
  /*
  * Fonction qui renvoie le point du milieu de entre (minX) et (minX + rangeX) et entre (minY) et (minY + rangeX)
  * 
  * @return Point : milieu
  */
  public Point calcMiddle() {
   Point toReturn = new Point((double) 0.0, (double) 0.0);
   toReturn.setX(this.minX + this.rangeX/2);
   toReturn.setY(this.minY + this.rangeY/2);
   return toReturn;
  }
}
