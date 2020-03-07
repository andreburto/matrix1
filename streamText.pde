class streamText {
  letterStream ls;
  int screenW = width;
  int screenH = height;
  int letterCounter = 0;
  int curPos = 0;
  int charX = 0;
  int charY = 0;
  int speed;
  float tintPercent = 255.0;
  float tintChange;
  float tintCurrent = 0.0;
  int tintFadeAfter = 3;
  boolean alive = true;
  
  public streamText(int x, int y, int charLen) {
    ls = new letterStream();
    setup(x, y, charLen);
  }
  
  public void setup(int x, int y, int charLen) {
    charX = x; charY = y; ls.setup(charLen);
    tintChange = floor(tintPercent / float(ls.getLength() - tintFadeAfter));
    alive = true;
  }
  
  public boolean isAlive() {
    return alive;
  }
  
  public boolean isX(int x) {
    return x == charX;
  }
  
  void setCursorPos() {
    charY += int(floor(CHAR_H));
    if (charY > screenH + (ls.getLength() * CHAR_H))
      alive = false;
  }
  
  void textCounter() {
    letterCounter += 1;
    if (letterCounter >= ls.getLength()) {
      letterCounter = 0;
    }
    curPos = (ls.getLength() - 1) - letterCounter;
  }
  
  int getLetterColor() {
    if (curPos == 0)
      return #aaffaa;
    else
      return #00ff00;
  }
  
  float getTint() {
    if (letterCounter < 1) {
      tintCurrent = 0.0;
      return 0.0;
    }
    else if (curPos < tintFadeAfter) {
      return tintPercent;
    }
    else {
      tintCurrent += tintChange;
      return tintCurrent;
    }
  }
  
  void work() {   
    if (letterCounter == 0)
      setCursorPos();
    
    int currentY = charY - (curPos * CHAR_H);
    float tintNow = getTint();
    
    if (currentY >= 0) {
      pg.beginDraw();
      pg.background(#000000);
      if (tintNow > 0.0) {
        pg.textFont(font, CHAR_W);
        pg.textAlign(CENTER, TOP);
        pg.fill(getLetterColor(), tintNow);
        pg.text(ls.getByIndex(letterCounter), (CHAR_W / 2), 0);
        pg.filter(BLUR, 1);
      }
      pg.endDraw();
      image(pg, charX, currentY, CHAR_W, CHAR_H);
    }
    textCounter();
    if (letterCounter > 0)
      work();
  }
}
