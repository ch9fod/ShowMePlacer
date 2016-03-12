class DrawScene { 
  PFont f;
  Button bStart,go;

  DrawScene() {  
    f = createFont("Arial", 18, true); 
    bStart = new Button(color(112, 173, 71), "Start!", width/2-100, height/2, 200, 100, 60);
    go = new Button(color(112, 173, 71), "GO", width/2-75, height/2+100, 100, 60, 50);
  }
  void scene1() {
    rectMode(CENTER);
    fill(218, 227, 243);  
    rect(width/2, height/2, 600, 800);  
    textFont(f, 120); 
    fill(0);
    textAlign(CENTER, BOTTOM);
    text("ShowMe", width/2, height/3);
    textAlign(CENTER, TOP);
    text("Placer", width/2, height/3);
    bStart.Draw();
  }
  void scene2() {
    String inst = "Use mouse clicks to create connections between blocks. Available spots for connections are visual dots on the edges of blocks. Use the + and – buttons to add external IO that can be used to connect blocks as well. To come back to this screen, use the back button.";
    rectMode(CENTER);
    fill(218, 227, 243);  
    rect(width/2, height/2, 600, 800); 
    go.Draw();
    textFont(f, 20); 
    fill(0);
    textAlign(LEFT);
    text("Instructions:", width/2-290, height/2+190);
    text(inst, width/2-290, height/2+205, 585, 400);
  }
  void scene3() {
    rectMode(CENTER);
    fill(218, 227, 243);  
    rect(width/2, height/2, 600, 800); 
  }  
}