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
    strokeWeight(3);
    rectMode(CORNER);
    rect(x, y, w, h, 5);
    textAlign(CENTER, CENTER);
    fill(0);
    textFont(f, fs);    
    text(label, x + (w/2), y + (h/2)-3);
    redraw();
  }
  
  boolean MouseIsOver() {
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {
      return true;
    }
    return false;
  }
}