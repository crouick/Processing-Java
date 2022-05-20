/*
 * Librairie qui gére les évenements du clavier
 */
void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      Double Tx = currentScene.getTrans().getX() + 0.05*currentScene.getRangeX();
      currentScene.getTrans().setX(Tx);
    }
    if (keyCode == RIGHT) {
      Double Tx = currentScene.getTrans().getX() - 0.05*currentScene.getRangeX();
      currentScene.getTrans().setX(Tx);
    }
    if (keyCode == UP) {
      Double Ty = currentScene.getTrans().getY() - 0.05*currentScene.getRangeY();
      currentScene.getTrans().setY(Ty);
    }
    if (keyCode == DOWN) {
      Double Ty = currentScene.getTrans().getY() + 0.05*currentScene.getRangeY();
      currentScene.getTrans().setY(Ty);
    }
  } else {

    if ((key == 'w')||(key == 'W')) {
      currentScene.setAngle(currentScene.getAngle() + 5.0);
    }
    if ((key == 'x')||(key == 'X')) {
      currentScene.setAngle(currentScene.getAngle() - 5.0);
    }

    if ((key == 'a')||(key == 'A')) {
      currentScene.setAgr(currentScene.getAgr()*1.05);
    }
    if ((key == 'z')||(key == 'Z')) {
      currentScene.setAgr(currentScene.getAgr()*0.95);
    }
    if ((key == 's')||(key == 'S')) {
      fractalCount--;
      if (fractalCount < 0) {
        fractalCount = tabFractalSize - 1;
      }
    }
    if ((key == 'd')||(key == 'D')) {
      fractalCount++;
      if (fractalCount > (tabFractalSize - 1)) {
        fractalCount = 0;
      }
    }

    if ((key == 't')||(key == 'T')) {
      displayText = !displayText;
    }
    if ((key == 'm')||(key == 'M')) {
      displayMenu = !displayMenu;
    }
    if ((key == 'y')||(key == 'Y')) {
      displayAxes = !displayAxes;
    }
    if ((key == 'f')||(key == 'F')) {
      drawFractal = !drawFractal;
    }
    if ((key == 'q')||(key == 'Q')) {
      exit();
    }
  }
}
