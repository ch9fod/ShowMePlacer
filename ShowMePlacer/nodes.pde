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
  int id;
  
  Nodes(int ID) {
    id = ID;
  }
  void Draw(PFont font) {
    if (en){
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
      text(id, x0m+8, y0m+8);
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
  void upButton(boolean toogle) {
    if (toogle){
      if (sel)
        bc = 0;      
      else
        bc = #FFFFFF;
      sel = !sel;
    }        
    else{
      sel = false;
      bc = 0;
    }
    fill(bc);
    stroke(0);
    strokeWeight(2); 
    rectMode(CENTER);
    rect(x0m, y0m, bsize, bsize);
    //println(id);  
  }  
  boolean isSel() {
    return sel;
  }  
  void UpInit(int x1){
    x0m = x0m + x1;
  }   
  void UpLoc(int x1, int y1){
    x0m = x1;
    y0m = y1;
  }  
}