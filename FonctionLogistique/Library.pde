/*
 * Librairie contenant diverses fonctions utiles
 */


/*
 * Fonction qui renvoie une couleur selon value comparé à limit sur une partie ou tout "l'arc en ciel"
 * qui est découpé en 6 parties
 *
 * @param Double value : valeur à comparer, valeur allant de 0 à limit
 * @param Double limit : maximum de value
 * @param Integer start : détermine la couleur de début du dégradé dans l'arc en ciel
 * @param Integer range : détermine la partie de l'arc en ciel utilisée par le dégradé (start + range <= 6)
 * @return color : couleur déterminée par la comparaison sur une partie ou tout "l'arc en ciel"
 */
public color calculateRVB(Double value, Double limit, Integer start, Integer range) {
  Integer red = 0;
  Integer green = 0;
  Integer blue = 0;

  if ((start + range) <= 6) {
    Double x = (Double) (start + range * value / limit);

    if (x >= 0 && x < 1) {
      red = 255;
    } else if (x >= 1 && x < 2) {
      red = (int)(255 - (x.floatValue() - 1)*255);
    } else if (x >= 2 && x < 4) {
      red = 0;
    } else if (x >= 4 && x < 5) {
      red = (int) ((x.floatValue() - 4)*255);
    } else if (x >= 5 && x <= 6) {
      red = 255;
    }

    if (x >= 0 && x < 1) {
      green = (int) (x.floatValue()*255);
    } else if (x >= 1 && x < 3) {
      green = 255;
    } else if (x >= 3 && x < 4) {
      green = (int)(255 - (x.floatValue() - 3)*255);
    } else if (x >= 4 && x <= 6) {
      green = 0;
    }

    if (x >= 0 && x < 2) {
      blue = 0;
    } else if (x >= 2 && x < 3) {
      blue = (int) ((x.floatValue() - 2)*255);
    } else if (x >= 3 && x < 5) {
      blue = 255;
    } else if (x >= 5 && x <= 6) {
      blue = (int)(255 - (x.floatValue() - 5)*255);
    }
  }
  return color(red, green, blue);
}

/*
 * Procédure qui dessine un dégradé horizontal de couleurs couvrant une partie ou tout
 * l'arc en ciel en bas de la fenêtre
 *
 * @param Integer thickness : épaisseur du dégradé
 * @param Integer start : détermine la couleur de début du dégradé dans l'arc en ciel
 * @param Integer range : détermine la partie de l'arc en ciel utilisée par le dégradé  (start + range <= 6)
 * @param Integer sizeX : largeur de la fenêtre (ou du dégradé)
 * @param Integer sizeY : hauteur de la fenêtre (ou position verticale du bas du dégradé)
 */
public void drawHorizGradient(Integer thickness, Integer start, Integer range, Integer sizeX, Integer sizeY) {
  for (int i=0; i<sizeX; i++) {
    stroke(calculateRVB((double) i, (double) sizeX, start, range));
    line(i, sizeY-thickness, i, sizeY);
  }
}
/*
public void drawVertGradient(Integer thickness, Integer start, Integer range, Integer sizeI, Integer sizeJ) {
 for (int j=0; j<sizeJ - 400; j++) {
 stroke(calculateRVB((double) j, (double) sizeJ - 400, start, range));
 line(100 - thickness, j + 100, 100, j + 100);
 }
 }
 */

/*
 * Fonction qui renvoie le log à base n de x
 *
 * @param Double n : base du log
 * @param Double x : valeur a traiter
 * @return Double : log à base n de x
 */
public Double log(Double n, Double x) {
  if (n>0 && x>0) {
    return (Double) (Math.log(x) / Math.log(n));
  }
  return null;
}

/*
 * Fonction qui renvoie la valeur en radian d'un angle en degré
 *
 * @param Double angleDegree : angle en degré
 * @return Double : angle en radian
 */
public Double degreeToRad(Double angleRad) {
  return (double) (angleRad * PI / 180);
}

/*
 * Fonction qui renvoie la valeur en degré d'un angle en radian
 *
 * @param Double angleRad : angle en radian
 * @return Double : angle en degré
 */
public Double radToDegree(Double angleDegree) {
  return (double) (angleDegree * 180 / PI);
}

/*
public float arr(Double x, Integer n) {
  float valToReturn = (Math.round(x * 100)) / 100; //Math.pow(10.0, n)
  println("val arr : " + valToReturn);
  return valToReturn;
}
*/

// Trouvée sur le net
void dashline(Double x0, Double y0, Double x1, Double y1, Double[] spacing) {
  Double distance = Math.sqrt((x1-x0)*(x1-x0) + (y1-y0)*(y1-y0));//Math.dist(x0, y0, x1, y1);
  Double [ ] xSpacing = new Double[spacing.length];
  Double [ ] ySpacing = new Double[spacing.length];
  Double drawn = (double) 0.0;  // amount of distance drawn

  if (distance > 0) {
    int i;
    boolean drawLine = true; // alternate between dashes and gaps

    /*
      Figure out x and y distances for each of the spacing values
     I decided to trade memory for time; I'd rather allocate
     a few dozen bytes than have to do a calculation every time
     I draw.
     */
    for (i = 0; i < spacing.length; i++) {
      xSpacing[i] = (double) lerp(0, (float) (x1 - x0), (float) (spacing[i] / distance));
      ySpacing[i] = (double) lerp(0, (float) (y1 - y0), (float) (spacing[i] / distance));
    }

    i = 0;
    while (drawn < distance) {
      if (drawLine) {
        line( x0.floatValue(), y0.floatValue(), (float) (x0 + xSpacing[i]), (float) (y0 + ySpacing[i]));
      }
      x0 += xSpacing[i];
      y0 += ySpacing[i];
      /* Add distance "drawn" by this line or gap */
      drawn = (double) (drawn + mag(xSpacing[i].floatValue(), ySpacing[i].floatValue()));
      i = (i + 1) % spacing.length;  // cycle through array
      drawLine = !drawLine;  // switch between dash and gap
    }
  }
}

/*
 * Draw a dashed line with given dash and gap length.
 * x0 starting x-coordinate of line.
 * y0 starting y-coordinate of line.
 * x1 ending x-coordinate of line.
 * y1 ending y-coordinate of line.
 * dash - length of dashed line in pixels
 * gap - space between dashes in pixels
 */
// Trouvée sur le net
void dashline(Double x0, Double y0, Double x1, Double y1, Double dash, Double gap)
{
  //println("entrée dans fonction dashline");
  Double [ ] spacing = { dash, gap };
  dashline(x0, y0, x1, y1, spacing);
}
