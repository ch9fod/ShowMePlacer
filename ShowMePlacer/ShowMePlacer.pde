DrawScene ds;
int scst = 0;
void setup() {
  fullScreen(2);
  background(0);
  noStroke();
  ds = new DrawScene();
  ds.scene1();  //draws first scene
}
void draw() {  //no code on draw
}
void mouseReleased() {
  switch(scst){
    case 0:
      scst = ds.sc1_CheckAndUpdate();  //checks for Start Button
      break;                            
    case 1:
      scst = ds.sc2_CheckAndUpdate();//checks for buttons inside scene2
      break;
    case 2:
      scst = ds.sc3_CheckAndUpdate();//checks for buttons inside scene3      
      break;
  }
}
void keyReleased() { // this is used for keyboard entry
    ds.CheckKey();
}