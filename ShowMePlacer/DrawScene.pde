class DrawScene { 
  PFont f;
  Button bStart,go,plSc2,mnSc2,back;
  Grid gridL;
  int blocks = 6;
  int sc3state;

  DrawScene() {  
    f = createFont("Arial", 18, true); 
    bStart = new Button(color(112, 173, 71), "Start!", width/2-100, height/2, 200, 100, 60);
    go = new Button(color(112, 173, 71), "GO", width/2-50, height/2+100, 100, 60, 50);
    plSc2 = new Button(color(112, 173, 71), "+", width/2+50, height/2-50, 40, 40, 35);
    mnSc2 = new Button(color(112, 173, 71), "-", width/2-90, height/2-50, 40, 40, 35);
    back = new Button(color(112, 173, 71), "Back", width/2+200, height/2+345, 85, 40, 30);
    gridL = new Grid();
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
    fill(47, 85, 151); 
    rect(width/2, height/2-30, 80, 40);     
    fill(0);  
    textFont(f, 70); 
    text("Set the complexity", width/2, height/4);
    textFont(f, 50); 
    text("Number of Blocks", width/2, height/3+40);
    textAlign(CENTER, BOTTOM);
    textFont(f, 35); 
    text(blocks, width/2, height/2-10);      
    textAlign(LEFT);
    textFont(f, 20);     
    text("Instructions:", width/2-290, height/2+190);
    text(inst, width/2, height/2+400, 585, 400);    
    go.Draw();
    plSc2.Draw();
    mnSc2.Draw();    
  }
  int scene2_update(int sum) {
    int a = sum;
    if (a == 1){
      if(blocks < 40)
        blocks++;
    }
    else{
      if (blocks > 6)
        blocks--;
    }    
    rectMode(CENTER);
    fill(47, 85, 151); 
    rect(width/2, height/2-30, 80, 40);     
    fill(0);  
    textAlign(CENTER, BOTTOM);
    textFont(f, 35); 
    text(blocks, width/2, height/2-10);      
    return 0;
  }
  void scene3() {
    rectMode(CENTER);
    fill(218, 227, 243);  
    rect(width/2, height/2, 600, 800);
    strokeWeight(1);
    fill(237, 237, 237);  
    rectMode(CORNER);
    rect(width/2-295, height/2-360, 290, 750);
    rect(width/2+5, height/2-360, 290, 750);
    fill(124, 124, 124);
    rect(width/2-290, height/2+130, 280, 250);
    back.Draw();
    gridL.UpNDraw(blocks);
  }  
  int sc3_checkbuttons() {
    //sc3state = 98; // nothing changed
    if (back.MouseIsOver())
      sc3state = 99;
    for(int i=0; i<blocks; i++){
      if (gridL.snodes[i].MouseIsOver())
        sc3state = i;
    }
    return sc3state;
  }   
  void scene3_update(int state) {
    //if (state != 98)  // nothing changed state
      gridL.snodes[state].upButton();
  }   
}