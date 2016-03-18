DrawScene ds; //<>//
int curScene = 1;
int sum = 0;
int sc3st = 100;
void setup() {
  fullScreen(2);
  background(0);
  noStroke();
  ds = new DrawScene();
  noLoop();
}
void draw() {
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
      if(sc3st == 100)
        ds.scene3();
      else
        ds.scene3_update(sc3st);
      break;    
  }
}
void mouseClicked() {
  if(curScene == 3){
   sc3st = ds.sc3_checkbuttons();
   if (sc3st == 99) curScene = 2;
   redraw();
  }    
  if(curScene == 2){
    if(ds.go.MouseIsOver()){
      curScene = 3;
      sc3st = 100;
    } else if(ds.plSc2.MouseIsOver()){
      sum = 1;
    } else if(ds.mnSc2.MouseIsOver()){
      sum = 2;
    }
    redraw();
  }
  if(curScene == 1 && ds.bStart.MouseIsOver()){
    curScene = 2;
    redraw();
  }  
}