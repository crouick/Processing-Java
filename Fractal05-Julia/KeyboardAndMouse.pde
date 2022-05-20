/*
 * Librairie qui gére les évenements du clavier
 */
void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      Double Tx = app.currentScene.getTrans().getX() + 0.05*app.currentScene.getRangeX();
      app.currentScene.getTrans().setX(Tx);
    }
    if (keyCode == RIGHT) {
      Double Tx = app.currentScene.getTrans().getX() - 0.05*app.currentScene.getRangeX();
      app.currentScene.getTrans().setX(Tx);
    }
    if (keyCode == UP) {
      Double Ty = app.currentScene.getTrans().getY() - 0.05*app.currentScene.getRangeY();
      app.currentScene.getTrans().setY(Ty);
    }
    if (keyCode == DOWN) {
      Double Ty = app.currentScene.getTrans().getY() + 0.05*app.currentScene.getRangeY();
      app.currentScene.getTrans().setY(Ty);
    }
  } else {

    if ((key == 'w')||(key == 'W')) {
      app.currentScene.setAngle(app.currentScene.getAngle() + 5.0);
    }
    if ((key == 'x')||(key == 'X')) {
      app.currentScene.setAngle(app.currentScene.getAngle() - 5.0);
    }

    if ((key == 'a')||(key == 'A')) {
      app.currentScene.setAgr(app.currentScene.getAgr()*1.05);
    }
    if ((key == 'z')||(key == 'Z')) {
      app.currentScene.setAgr(app.currentScene.getAgr()*0.95);
    }
    if ((key == 's')||(key == 'S')) {
      app.fractalCount--;
      if (app.fractalCount < 0) {
        app.fractalCount = app.tabFractalSize - 1;
      }
    }
    if ((key == 'd')||(key == 'D')) {
      app.fractalCount++;
      if (app.fractalCount > (app.tabFractalSize - 1)) {
        app.fractalCount = 0;
      }
    }

    if ((key == 't')||(key == 'T')) {
      app.displayText = !app.displayText;
    }
    if ((key == 'm')||(key == 'M')) {
      app.displayMenu = !app.displayMenu;
    }
    if ((key == 'y')||(key == 'Y')) {
      app.displayAxes = !app.displayAxes;
    }
    if ((key == 'f')||(key == 'F')) {
      app.drawFractal = !app.drawFractal;
    }
    if ((key == 'q')||(key == 'Q')) {
      exit();
    }
  }
}
