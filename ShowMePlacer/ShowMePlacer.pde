DrawScene ds; //<>//
int scst = 0;
void setup() {
  fullScreen(2);
  background(0);
  noStroke();
  ds = new DrawScene();
  ds.scene1();  //draws first scene
}
void draw() {
}
void mouseReleased() {
  switch(scst){
    case 0:
      scst = ds.sc1_CheckAndUpdate();  //Checks for Start Button
      break;                            
    case 1:
      scst = ds.sc2_CheckAndUpdate();
      break;
    case 2:
      scst = ds.sc3_CheckAndUpdate();      
      break;
  }
}
void keyReleased() {
    ds.CheckKey();
}
  //import ddf.minim.*;
  //Minim minim;
  //AudioPlayer song1,song2,song3;
  //minim = new Minim(this);
  //song1 = minim.loadFile("sc1.mp3");
  //song2 = minim.loadFile("sc2.mp3");
  //song3 = minim.loadFile("sc3.mp3");