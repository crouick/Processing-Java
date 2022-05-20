/*
 * Classe représentant les paramètres de calcul de la fractale de Julia
 */
class JuliaFractal {
 private ComplexNb seed; // seed (c) de la fractale
 private Double limit; // limite du module de la boucle de calcul de la fractale
 private Integer maxIt; // maximum d'itérations de la boucle de calcul de la fractale
 
 /*
  * Constructeur
  */
 public JuliaFractal(ComplexNb seed, Double limit, Integer maxIt) {
  this.seed = seed;
  this.limit = limit;
  this.maxIt = maxIt;
 }
 
 public ComplexNb getSeed() {
  return this.seed; 
 }
 public Double getLimit() {
  return this.limit; 
 }
 public Integer getMaxIt() {
  return this.maxIt; 
 }
 
 public void setSeed(ComplexNb seed) {
  this.seed = seed; 
 }
 public void setLimit(Double limit) {
  this.limit = limit; 
 }
 public void setMaxIt(Integer maxIt) {
  this.maxIt = maxIt; 
 }
 
 public String toString() {
  return"seed : " + this.seed.toString() + " limit : " + this.limit + " maxIt : " + this.maxIt; 
 }
}
