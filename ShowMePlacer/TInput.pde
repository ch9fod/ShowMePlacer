class TInput {//Text input class
  
  PFont f;
  String label, def;
  int x, y, w, h, fs, limit;
  boolean en = false;
  
  TInput(String lbl, String defa, int xTop, int yTop, int widthT, int heightT, int fSize, int lenLimit) {
  f = createFont("Arial", 18, true);
  label = lbl;
  def = defa;
  x = xTop;
  y = yTop;
  w = widthT;
  h = heightT;
  fs = fSize;
  limit = lenLimit;
  }
  void DrawRec(boolean over){
    if(over)
      strokeWeight(5);
    else
      strokeWeight(1);
    fill(0);  
    stroke(#FF0000);
    rectMode(CORNER);
    rect(x, y, w, h);
    textAlign(LEFT);
    fill(#FFFFFF);
    textFont(f, fs);    
    text(def, x+5, y+h-5);
    //text(def, x, y-2);
  }
  void DrawLabel(){
    fill(0);
    textAlign(RIGHT);
    textFont(f, fs);    
    text(label, x-2 , y+h-2);
  }
  float Update(){
    if(key == BACKSPACE){
      if (!def.isEmpty()){
        def = def.substring(0,def.length()-1);
      }
    }
    else if((key >= '0' && key <= '9') || key == '.'){
      if(def.length() < limit){
        def = def + key;
      }
    }
    DrawRec(true);
    return float(def);
  }
  boolean MouseIsOver() {
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {
      return true;
    }
    return false;
  }
  boolean Toogle() {
    en = !en;
    DrawRec(en);
    return en;
  }
  boolean IsEn() {
    return en;
  }  
}