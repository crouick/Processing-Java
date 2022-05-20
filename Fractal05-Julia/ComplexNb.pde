/*
 * Classe qui représente les nombres complexes
 */
class ComplexNb {

  private Double real; // partie réelle
  private Double imag; // partie imaginaire
  private Double mod; // module
  private Double arg; // argument en degré

/*
 * Constructeur selon le choix
 * choix = "Cart" : construction à partir des données cartésiennes et calcul des données trigonométriques
 * choix = "Trig" : construction à partir des données trigonométriques et calcul des données cartésiennes
 */
  public ComplexNb (String choice, Double value1, Double value2) {
    if (choice=="Cart") {
      this.real = value1;
      this.imag = value2;
      this.mod = (Double) Math.sqrt(value1*value1 + value2*value2);
      this.arg = (Double) radToDegree(Math.atan2(value2, value1));
    } else if (choice=="Trig") {
      this.mod = value1;
      this.arg = value2;
      this.real = (Double) (value1*Math.cos(degreeToRad(value2)));
      this.imag = (Double) (value1*Math.sin(degreeToRad(value2)));
    } else {
      this.real = null;
      this.imag = null;
      this.mod = null;
      this.arg = null;
    }
  }

  public void setReal(Double real) {
    this.real = real;
  }
  public void setImag(Double imag) {
    this.imag = imag;
  }
  public void setMod(Double mod) {
    this.mod = mod;
  }
  public void setArg(Double arg) {
    this.arg = arg;
  }

  public Double getReal() {
    return this.real;
  }
  public Double getImag() {
    return this.imag;
  }
  public Double getMod() {
    return this.mod;
  }
  public Double getArg() {
    return this.arg;
  }
  
  public void updateTrigo() {
    this.mod = (Double) Math.sqrt(this.real*this.real + this.imag*this.imag);
    this.arg = (Double) radToDegree(Math.atan2(this.imag, this.real));
  }
  public void updateCart() {
    this.real = (Double) (this.mod*Math.cos(degreeToRad(this.arg)));
    this.imag = (Double) (this.mod*Math.sin(degreeToRad(this.arg)));
  }
  public ComplexNb conj() {
        return new ComplexNb("Cart", this.real, -1*this.imag);
  }
  public ComplexNb add(ComplexNb toAdd) {
        return new ComplexNb("Cart", this.real + toAdd.getReal(), this.imag + toAdd.getImag());
  }
  public ComplexNb sub(ComplexNb toSub) {
        return new ComplexNb("Cart", this.real - toSub.getReal(), this.imag - toSub.getImag());
  }
  public ComplexNb mult(ComplexNb toMult) {
        return new ComplexNb("Cart", this.real*toMult.getReal() - this.imag*toMult.getImag(),
        this.real*toMult.getImag() + this.imag*toMult.getReal());
  }
  /*
        Division of Complex numbers (doesn't change this Complex number).
        <br>(x+i*y)/(s+i*t) = ((x*s+y*t) + i*(y*s-y*t)) / (s^2+t^2)
        @param w is the number to divide by
        @return new Complex number z/w where z is this Complex number  
    */
  public ComplexNb div(ComplexNb toDiv) {
        //double den=Math.pow(toDiv.mod(),2);
        Double modSq = toDiv.getMod()*toDiv.getMod();
        return new ComplexNb("Cart", (this.real*toDiv.getReal() + this.imag*toDiv.getImag())/modSq, 
        (this.imag*toDiv.getReal() - this.real*toDiv.getImag())/modSq);
  }
  
  public String toString() {
   return " real : " + this.real + " imag : " + this.imag + " mod : " + this.mod + " arg : " + this.arg; 
  }
}
