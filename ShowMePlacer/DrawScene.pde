class DrawScene { 
  PFont f;
  Button bStart,go,plSc2,mnSc2,back;
  Grid gridL;
  int blocks = 6;
  int sc3Bstate = 50;
  int scState = 0;  

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
  int sc1_CheckAndUpdate() {  
    if(bStart.MouseIsOver()){
      scState = 1;
      scene2();
    }      
    return scState;
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
  int sc2_CheckAndUpdate() {  
    if(plSc2.MouseIsOver()){
      if(blocks < 40){
        blocks++;
        sc2_UpBlocks();
      }
    } 
    else if(mnSc2.MouseIsOver()){
      if (blocks > 6){
        blocks--;
        sc2_UpBlocks();
      }
    } 
    else if(go.MouseIsOver()){
      scState = 2;
      scene3();
    }     
    return scState;
  }  
  void sc2_UpBlocks() {   
    rectMode(CENTER);
    fill(47, 85, 151); 
    rect(width/2, height/2-30, 80, 40);     
    fill(0);  
    textAlign(CENTER, BOTTOM);
    textFont(f, 35); 
    text(blocks, width/2, height/2-10);
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
  int sc3_CheckAndUpdate() {
    if (back.MouseIsOver()){
      scState = 1;
      scene2();
    }
    else{
      sc3Bstate = 50;  //reset buttons state
      for(int i=0; i<blocks; i++){
       if (gridL.snodes[i].MouseIsOver())
         sc3Bstate = i;
      }
      if (sc3Bstate!= 50){
        gridL.snodes[sc3Bstate].upButton();
      }
    }
    return scState;
  }    
}