class Button {
  PFont f;    
  color c;  
  String label;
  float x;    // top left corner x position
  float y;    // top left corner y position
  float w;    // width of button
  float h;    // height of button
  float fs;   // font size
  
  Button(color bColor, String labelB, float xpos, float ypos, float widthB, float heightB, float fSize) {
    f = createFont("Arial", 18, true);
    c = bColor;
    label = labelB;
    x = xpos;
    y = ypos;
    w = widthB;
    h = heightB;
    fs = fSize;
  }
  
  void Draw() {
    fill(c);  
    stroke(0);
    strokeWeight(4);
    rectMode(CORNER);
    rect(x, y, w, h, 10);
    textAlign(CENTER, CENTER);
    fill(0);
    textFont(f, fs);    
    text(label, x + (w/2), y + (h/2));
  }
  
  boolean MouseIsOver() {
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {
      return true;
    }
    return false;
  }
}
class Grid {
  PFont f;    
  int nNodes;
  int size = 40;
  int x0 = width/2-225;
  int y0 = height/2-330;
  Nodes[] snodes = new Nodes[39];
  color[] colors = {color(0,255,255), color(255,0,255), color(255,255,0),
                    color(0,0,255), color(0,255,0), color(255,0,0)};
  int colCount = 0;                     
  
  Grid() {
    f = createFont("Arial", 18, true);    
    for(int i=0; i<snodes.length; i++) {
        snodes[i] = new Nodes(i);
    }
  }
  void UpNDraw(int Nodes){
    for(int k=0; k<snodes.length; k++) {
        snodes[k].Clear();
    }
    nNodes = Nodes;
    int j = 0, i = 0 ,n = 0;    
     while(n<nNodes){
       snodes[n].Update(true, x0+(size+10)*i, y0+(size+10)*j, getCol());
       snodes[n].Draw(f,n);
       i++;
       if(i>3){
         j++;
         i=0;
       }
       n++;
    }  
  }    
  color getCol(){
    colCount++;
    if (colCount>5) colCount=0;
    return colors[colCount];
  }  
}