ArrayList<streamText> st = new ArrayList<streamText>();
int cnt = 0;
IntList charRange;
PFont font;
PGraphics pg;

int CHAR_W = 32;
int CHAR_H = 32;
int MAX_LEN = 10;
int MIN_LEN = 5;
int MAX_OBJ = 15;
int MIN_OBJ = 10;

void setup() {
  makeRandomRange();
  fullScreen(P2D);
  int obj_count = int(random(MIN_OBJ, MAX_OBJ));
  pg = createGraphics(CHAR_H, CHAR_W, P2D);
  for (int c = 0; c < obj_count; c++) {
    st.add(new streamText(randomX(), 0, randomLength()));
  }
  font = loadFont("Verdana-48.vlw");
  frameRate(int(20 * obj_count));
  background(#000000);
  noCursor();
}

void draw() {
  streamText currentObj = st.get(cnt);
  currentObj.work();
  if (currentObj.isAlive() == false) {
    int rl = randomLength();
    currentObj.setup(randomX(), randomY(rl), rl);
  }

  cnt += 1;
  if (cnt >= st.size())
    cnt = 0;
}

int randomLength() {
  return int(floor(random(MIN_LEN, MAX_LEN))); 
}

boolean hasX(int x) {
  for (int c = 0; c < st.size(); c++) {
    streamText currentObj = st.get(c);
    if (currentObj.isX(x))
      return true;
  }
  return false;
}

int randomX() {
  int x = int(random(floor(width / CHAR_W) + 1)) * CHAR_W;
  if (hasX(x))
    x = randomX();
  return x;
}

int randomY(int textLen) {
  return int(random(textLen) * CHAR_H) * -1;
}

void appendRange(int start, int stop) {
  for (int c = start; c <= stop; c++) {
    charRange.append(c);
  }
}

void makeRandomRange() {
  charRange = new IntList();
  appendRange(97, 122);
  appendRange(65, 90);
  appendRange(48, 57);
}
