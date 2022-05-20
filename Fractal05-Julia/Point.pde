/*
 * Classe représentant un point du plan des réels
 */
class Point {
 private Double x;
 private Double y;
 
 public Point(Double x, Double y) {
  this.x = x;
  this.y = y;
 }
  
 public void setX(Double x) {
  this.x = x; 
 }
 public void setY(Double y) {
  this.y = y; 
 }
 public Double getX() {
  return this.x; 
 }
 public Double getY() {
  return this.y; 
 }
 public String toString() {
  return "x : " + x + " / y : " + y; 
 }
 
 public Double calcMagnitude() {
  return (double) Math.sqrt(this.x*this.x + this.y*this.y); 
 }
 
 public Double calcAngle() {
  return radToDegree(Math.atan2(this.y, this.x)); 
 }
 
 public Double calcDist(Point endPoint) {
   return Math.sqrt((endPoint.getX() - this.x)*(endPoint.getX() - this.x) + (endPoint.getY() - this.y)*(endPoint.getY() - this.y));
 }
}
