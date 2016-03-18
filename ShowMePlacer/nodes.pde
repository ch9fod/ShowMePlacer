class Nodes {
  int nNodes;
  int x0m,y0m;
  color c,bc;
  int size = 40;
  int bsize = 5;
  boolean en = false;
  boolean sel = false;  
  PFont f;
  int fs = 18;   // font size
  int l;
  int id;
  
  Nodes(int ID) {
    id = ID;
  }
  void Draw(PFont font, int label) {
    if (en){
      l = label;
      f = font;
      stroke(0);
      strokeWeight(2);
      rectMode(CENTER);
      fill(c); 
      rect(x0m, y0m, size, size, 7);
      fill(0); 
      rect(x0m, y0m, bsize, bsize);      
      textAlign(CENTER, CENTER);
      fill(0);
      textFont(f, fs);    
      text(label, x0m+8, y0m+8);  
    }
  }
  void Update(boolean Enabled,int Xpos, int Ypos, color Color) {
    x0m = Xpos;
    y0m = Ypos;
    c = Color;
    en = Enabled;
  }  
  void Clear() {
    x0m = 0;
    y0m = 0;
    en = false;
  }
  boolean MouseIsOver() {
    if (mouseX > x0m-8 && mouseX < x0m+8 && mouseY > y0m-8 && mouseY < y0m+8) {
      return true;
    }
    return false;
  }
  void upButton() {
    if (sel)
      bc = 0;      
    else
      bc = #FFFFFF;
    fill(bc);
    stroke(0);
    strokeWeight(2);    
    rect(x0m, y0m, bsize, bsize);
    sel = !sel;
    println(id);
  }  
}