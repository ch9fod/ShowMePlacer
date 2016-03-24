class Grid {
  PFont f;    
  int nNodes;
  int size = 40;
  int x0 = width/2-225;
  int y0 = height/2-330;
  int Ix0 = width/2-270;
  int Iy0 = height/2-330;
  Nodes[] snodes = new Nodes[36];
  IO[] Is = new IO[9];
  IO[] Os = new IO[9];
  color[] colors = {color(0,255,255), color(255,0,255), color(255,255,0),
                    color(0,0,255), color(0,255,0), color(255,0,0)};
  int colCount = 0;
  int I = 1;
  int O = 1;
  
  Grid() {
    f = createFont("Arial", 18, true);    
    for(int i=0; i<snodes.length; i++) {
        snodes[i] = new Nodes(i);
    }
    for(int i=0; i<Is.length; i++) {
        Is[i] = new IO(i,1);
    }  
    for(int i=0; i<Os.length; i++) {
        Os[i] = new IO(i,0);
    }      
  }
  void UpNDraw(int Nodes, int inputs, int outputs){
    for(int k=0; k<snodes.length; k++) {
        snodes[k].Clear();
    }
    nNodes = Nodes;
    int j = 0, i = 0 ,n = 0;    
     while(n<nNodes){
       snodes[n].Update(true, x0+(size+10)*i, y0+(size+10)*j, getCol());
       snodes[n].Draw(f);
       i++;
       if(i>3){
         j++;
         i=0;
       }
       n++;
    }
    UpNDrawIO(inputs, outputs);
  }    
  color getCol(){
    colCount++;
    if (colCount>5) colCount=0;
    return colors[colCount];
  }
  void UpNDrawIO(int inputs, int outputs){
    for(int k=0; k<Is.length; k++) {
      Is[k].Clear();
    }
    for(int k=0; k<Os.length; k++) {
      Os[k].Clear();
    }
    int in = inputs;
    int out = outputs;    
    for(int i=0; i<in; i++){
      Is[i].Update(true, Ix0, Iy0+(size+10)*i);
      Is[i].Draw(f);
    }    
    for(int i=0; i<out; i++){
     Os[i].Update(true, Ix0+240, Iy0+(size+10)*i);
     Os[i].Draw(f);
    }    
  }
  void UpInitials(int x1){
    Ix0 = Ix0 + x1;
    for(int i=0; i<snodes.length;i++){
      if(snodes[i].en){
        snodes[i].UpInit(x1);
        snodes[i].Draw(f);
      }
    }
    for(int i=0; i<Is.length;i++){
      if(Is[i].en){
        Is[i].UpInit(Ix0);
        Is[i].Draw(f);
      }
    }
    for(int i=0; i<Os.length;i++){
      if(Os[i].en){
        Os[i].UpInit(Ix0+240);
        Os[i].Draw(f);
      }
    }
  }
  void ReDraw(){
    for(int i=0; i<snodes.length;i++){
      if(snodes[i].en)
        snodes[i].Draw(f);
    }
  }
}