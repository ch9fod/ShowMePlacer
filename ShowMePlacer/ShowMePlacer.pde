DrawScene ds; //<>//
int scst = 0;
void setup() {
  fullScreen(2);
  background(0);
  noStroke();
  ds = new DrawScene();
  ds.scene1();
}
void draw() {
}
void mouseReleased() {
  switch(scst){
    case 0:
      scst = ds.sc1_CheckAndUpdate();  //Checks for Start Button 
      break;                           //and draws scene2 
    case 1:
      scst = ds.sc2_CheckAndUpdate();
      break;
    case 2:
      scst = ds.sc3_CheckAndUpdate();
      break;
  }
}