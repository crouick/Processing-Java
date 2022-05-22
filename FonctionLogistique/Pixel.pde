/*
 * Classe représentant un pixel d'une fenêtre de hauteur SIZE_J
 */
class Pixel {
 private Integer i; // coordonnée horizontale du pixel
 private Integer j; // coordonnée verticale du pixel
 
 /*
  * Constructeur
  */
 public Pixel(Integer i, Integer j) {
  this.i =i;
  this.j =j;
 }
 
 public void setI(Integer i) {
  this.i = i; 
 }
 public void setJ(Integer j) {
  this.j = j; 
 }
 public Integer getI() {
  return this.i; 
 }
 public Integer getJ() {
  return this.j; 
 }
 
 /*
  * Fonction qui renvoie la coordonnée verticale du pixel pour tenir compte de "l'inversement"
  * de l'axe vertical de la fenêtre
  */
 public Integer getJToDraw(Integer SIZE_J) {
  return (SIZE_J - this.j -1); 
 }
 public String toString() {
  return "i : " + this.i + " / j : " + this.j; 
 }
}
