class letterStream {
  int charLen;
  IntList charStream = new IntList();
  
  public void setup(int len) {
    charLen = len;
    charStream.clear();
    for (int c = 0; c < charLen - 1; c++) {
      charStream.append(randomIntFromRange());
    }
  }
  
  public char getByIndex(int idx) {
    if (idx == getLength() - 1)
      return char(randomIntFromRange());
    else
      return char(charStream.get(idx)); 
  }
  
  public int getLength() {
    return charLen;
  }
  
  public int randomIntFromRange() {
    return charRange.get(int(random(charRange.size() - 1)));
  } 
}
