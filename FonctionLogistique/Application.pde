class Application {
  private final Integer sizeI;
  private final Integer sizeJ;
  private Integer stepI = 20;
  private Integer nbItMax = 500 + 1;
  private Integer startIt;
  Slider sliderX0, sliderCoef, sliderStartIt; //, sliderCoef
  Double xStart = (double) 0.5;
  Double coef = (double) 3.0;
  Double[] tabX;

  public Application(Integer sizeI, Integer sizeJ) {
    this.sizeI = sizeI;
    this.sizeJ = sizeJ;
  }

  public void init() {
    color bGColor = color(20, 20, 20);
    color kZColor = color(80, 80, 80);
    color stkColor = color(120, 120, 120);
    color stkColorOn = color(255, 200, 0);
    sliderX0 = new Slider(100, sizeJ - 130, 780, 30, 10, 0.0, 1.0, xStart.floatValue(), bGColor, kZColor, stkColor, stkColorOn);
    sliderX0.init();
    sliderCoef = new Slider(920, sizeJ - 130, 780, 30, 10, 1.0, 4.0, coef.floatValue(), bGColor, kZColor, stkColor, stkColorOn);
    sliderCoef.init();
    Integer nbIt = 1 + (sizeI - 200)/stepI;
    startIt = 0;
    //println("max it : " + (nbItMax - nbIt + 1) + " nbIt : " + nbIt);
    sliderStartIt = new Slider(100, sizeJ - 200, 1600, 30, 10, 0.0, (float) (nbItMax - nbIt), (float) startIt, bGColor, kZColor, stkColor, stkColorOn); // (nbItMax - nbIt) //nbItMax - nbIt
    sliderStartIt.init();
    //nbItMax = 200;
    
    //nbItMax = 1 + (sizeI - 200)/stepI; // ****************************
    tabX = new Double[nbItMax];
    //println("init ok");
  }

  public void run() {

    drawAxes(this.sizeI, this.sizeJ, startIt);
    //println("ok !!");
    displayMenu(this.sizeI, this.sizeJ);
    fillTabX(tabX, xStart, coef, nbItMax);
    drawTabX(tabX, xStart, startIt, stepI);
    //drawFunction(xStart, coef); // xStart
    xStart = sliderX0.run();
    coef = sliderCoef.run();
    
    Double value = sliderStartIt.run();
    startIt = (int) Math.round(value);
    displayText(xStart);
    //println("run ok");
  }

  public void fillTabX(Double[] tabX, Double xStart, Double coef, Integer nbIt) {
    //Double[] tabToReturn = new Double[nbIt];
    tabX[0] = xStart;
    Double x= xStart;
    for (int i=1; i<(nbIt); i++) {
      x = coef*x*(1-x);
      tabX[i] = x;
      //println("remp i : " + i + " x : " + tabX[i]);
    }
    //return tabToReturn;
  }

  public void drawTabX(Double[] tabX, Double xStart, Integer startIt, Integer stepI) {
    //println("test tab de 1 : " + tabX[1]);
    Integer rangeIt = (sizeI - 200)/stepI;
    //println("range it : " + (rangeIt + startIt));
    for (int i=startIt; i<=(rangeIt + startIt); i++) {

      Double x = (double) tabX[i];
      //println("lect i : " + i + " x : " + tabX[i]);
      color fillColor =  calculateRVB((1 - x), (double) 1.0, 1, 5);
      //println("i : " + i);
      drawPoint(x, i - startIt, fillColor, stepI);
      //printPoint(x, i);

      //tabX[i] = x;
      fillColor =  calculateRVB((1 - xStart), (double) 1.0, 1, 5);
      stroke(fillColor); //stroke(fillColor);
      strokeWeight(2);
      if (i>startIt) {
        fillColor =  calculateRVB((1 - xStart), (double) 1.0, 1, 5);
        stroke(fillColor); //stroke(fillColor);
        strokeWeight(2);
        line(100 + (i-1-startIt)*stepI, getJFromX(tabX[i-1], sizeJ), 100 + (i-startIt)*stepI, getJFromX(tabX[i], sizeJ));
        strokeWeight(0.5);
        stroke(color(100, 100, 100));
        line(100 + (i-startIt)*stepI, getJFromX(tabX[i], sizeJ), 100 + (i-startIt)*stepI, getJFromX((double) 0.0, sizeJ));
        
      }
    }
  }
/*
  public void drawFunction(Double xStart, Double coef) {
    color fillColor =  calculateRVB((1 - xStart), (double) 1.0, 1, 5);
    drawPoint(xStart, 0, fillColor, stepI);
    //nbIt = 1 + (sizeI - 200)/stepI;
    //println("nb it : " + nbIt);
    Double[] tabX = new Double[nbItMax];
    tabX[0] = xStart;
    //printPoint(tabX[0], 0);
    Double x= xStart;
    for (int i=1; i<(nbItMax); i++) {
      x = coef*x*(1-x);
      fillColor =  calculateRVB((1 - x), (double) 1.0, 1, 5);
      drawPoint(x, i, fillColor, stepI);
      //printPoint(x, i);

      tabX[i] = x;
      fillColor =  calculateRVB((1 - xStart), (double) 1.0, 1, 5);
      stroke(fillColor); //stroke(fillColor);
      strokeWeight(2);
      line(100 + (i-1)*stepI, getJFromX(tabX[i-1], sizeJ), 100 + i*stepI, getJFromX(tabX[i], sizeJ));
    }
  }
*/
  public void printPoint(Double x, Integer n) {
    println(" n : " + n + " x : " + x);
  }

  public void drawPoint(Double x, Integer n, color fillColor, Integer stepI) {
    Pixel pix = new Pixel (0, 0);
    pix.setI(100 + n*stepI);
    pix.setJ(getJFromX(x, this.sizeJ));
    fill(fillColor);
    stroke(150, 150, 150);
    strokeWeight(0.5);
    circle(pix.getI(), pix.getJ(), 15);
  }


  public Integer getJFromX(Double x, Integer sizeJ) {
    Integer j = (int) (100 + (sizeJ - 400)*(1 - x)); // 100 -> sizeJ - 400
    return j;
  }
  
  public Double getXfromJ(Integer j, Integer sizeJ) {
    Double x = (double) (j - sizeJ - 300)/(400 - sizeJ);
   return (double) x; 
  }

  public void drawAxes(Integer sizeI, Integer sizeJ, Integer startIt) {

    stroke(127, 127, 127);
    fill(0, 0, 0);
    strokeWeight(1);
    //rect(0, sizeJ - 200 -1, sizeI - 1, 200);
    //rect(0, 0, sizeI - 1, sizeJ - 200 - 1);
    rect(0, 0, sizeI - 1, sizeJ - 1);
    line(0, sizeJ - 240, sizeI - 1, sizeJ - 240);
    drawVertGradient(8, 1, 5, sizeJ);
    strokeWeight(3);
    stroke(255, 255, 255);
    line(100, 100, 100, sizeJ - 300 - 1 + 5);
    line(100 - 15, sizeJ - 300 - 1, sizeI - 100 - 1, sizeJ - 300 - 1);
    line(100 - 15, 100, 100, 100);
    strokeWeight(1);
    textSize(12);
    fill(255, 255, 255);
    line(100 - 15, getJFromX((double) 0.5, sizeJ), 100, getJFromX((double) 0.5, sizeJ));
    for(Double x = (double) 0.1; x<= (double) 1; x=x + (double) 0.1) {
      //if(x != 0.5) {
        line(100 - 15, getJFromX(x, sizeJ), 100, getJFromX(x, sizeJ));
        text(nf(x.floatValue(), 1, 1), 100 - 35, getJFromX((double) x, sizeJ)); //
      //}
    }
    
    
    textSize(18);
    text("0", 100 - 35, sizeJ - 300 - 1);
    //text("0,5", 100 - 45, getJFromX((double) 0.5, sizeJ));
    text("1", 100 - 35, 100);
    Integer count = 0;
    textSize(12);
    strokeWeight(2);
    for (int i=100; i<=sizeI - 100; i = i+stepI) {
      line(i, sizeJ - 300 - 1, i, sizeJ - 300 - 1 + 5);
      text((count + startIt), i - 5, sizeJ - 300 - 1 + 30);
      count++;
    }
    //drawVertGradient(5, 0, 6, sizeI, sizeJ);
  }

  public void displayText(Double xStart) {
    fill(255, 255, 255);
    textSize(36);
    text("U(0) : " + nf(xStart.floatValue(), 1, 3), 100, sizeJ - 40);
    text("constante : " + nf(coef.floatValue(), 1, 3), 920, sizeJ - 40);
    textSize(24);
    //nf(d, 10, 4)
    text("U(n+1) = " + nf(coef.floatValue(), 1, 3) + "*U(n)*(1-U(n)) avec U(0) = " + nf(xStart.floatValue(), 1, 3) 
    + " sur " + (nbItMax - 1) + " itérations", 100, 60);
  }

  public void displayMenu(Integer sizeI, Integer sizeJ) {
    fill(255, 255, 255);
    textSize(24);
    text("[Q] : quitter", sizeI - 220, 60);
  }

  public void drawVertGradient(Integer thickness, Integer start, Integer range, Integer sizeJ) {
    for (int j=0; j<sizeJ - 400; j++) {
      stroke(calculateRVB((double) j, (double) sizeJ - 400, start, range));
      line(100 - thickness, j + 100, 100, j + 100);
    }
  }
}
