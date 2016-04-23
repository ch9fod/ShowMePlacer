class IO { //class that controls the IOs
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
  void Draw(PFont font) {
    if (en){
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
      text(id, x0m+10, y0m-2); 
      redraw();
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
    if (mouseX > x0m-10 && mouseX < x0m+10 && mouseY > y0m-10 && mouseY < y0m+10) {
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
    x0m = x1;
  }  
}