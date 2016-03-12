DrawScene ds; //<>//
int curScene = 1;
boolean dibu = true;
void setup() {
  fullScreen(2);
  background(0);
  noStroke();
  ds = new DrawScene();
  noLoop();
}
void draw() {
  if (dibu) {
    switch(curScene){
      case 1:
        ds.scene1();
        break;
      case 2:
        ds.scene2();
        break;
      case 3:
        ds.scene3();
        break;        
    }    
  }
  dibu = false;
}

void mouseClicked() {
  if(curScene == 1 && ds.bStart.MouseIsOver()){
    dibu = true;
    curScene = 2;
    redraw();
  }
  if(curScene == 2 && ds.go.MouseIsOver()){
    dibu = true;
    curScene = 3;
    redraw();
  }  
    
}