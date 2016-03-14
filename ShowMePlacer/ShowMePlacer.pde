DrawScene ds; //<>//
int curScene = 1;
boolean dibu = true;
int sum = 0;
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
        if(sum > 0)
          sum = ds.scene2_update(sum);
        else        
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
  if(curScene == 2){
    if(ds.go.MouseIsOver()){
      dibu = true;
      curScene = 3;
      redraw();
    }
    if(ds.plSc2.MouseIsOver()){
      dibu = true;
      sum = 1;
      redraw();
    }
    if(ds.mnSc2.MouseIsOver()){
      dibu = true;
      sum = 2;
      redraw();
    }     
  } 
}