class IO {
  int nNodes;
  int x0m,y0m;
  color c = #FFFFFF;
  color bc;
  int xsize = 40;
  int ysize = 15;
  int bsize = 5;
  boolean en = false;
  boolean sel = false;  
  PFont f;
  int fs = 16;   // font size
  int l;
  int id;
  int IorO;
  
  IO(int ID, int InOrOut) {
    id = ID;
    IorO = InOrOut;
  }
  void Draw(PFont font, int label) {
    if (en){
      l = label;
      f = font;
      stroke(0);
      strokeWeight(2);
      rectMode(CENTER);
      fill(c); 
      rect(x0m, y0m, xsize, ysize, 7);
      fill(0); 
      rect(x0m, y0m, bsize, bsize);      
      textAlign(CENTER, CENTER);
      fill(0);
      textFont(f, fs);    
      text(label, x0m+10, y0m-2);  
    }
  }
  void Update(boolean Enabled,int Xpos, int Ypos) {
    x0m = Xpos;
    y0m = Ypos;
    en = Enabled;
  }  
  void Clear() {
    if (en){
      en = false;
      stroke(237, 237, 237);
      strokeWeight(3);
      rectMode(CENTER);
      fill(237, 237, 237); 
      rect(x0m, y0m, xsize, ysize, 7);
    }
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
}