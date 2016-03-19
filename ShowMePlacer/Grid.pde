class Grid {
  PFont f;    
  int nNodes;
  int size = 40;
  int x0 = width/2-225;
  int y0 = height/2-330;
  Nodes[] snodes = new Nodes[39];
  color[] colors = {color(0,255,255), color(255,0,255), color(255,255,0),
                    color(0,0,255), color(0,255,0), color(255,0,0)};
  int colCount = 0;                     
  
  Grid() {
    f = createFont("Arial", 18, true);    
    for(int i=0; i<snodes.length; i++) {
        snodes[i] = new Nodes(i);
    }
  }
  void UpNDraw(int Nodes){
    for(int k=0; k<snodes.length; k++) {
        snodes[k].Clear();
    }
    nNodes = Nodes;
    int j = 0, i = 0 ,n = 0;    
     while(n<nNodes){
       snodes[n].Update(true, x0+(size+10)*i, y0+(size+10)*j, getCol());
       snodes[n].Draw(f,n);
       i++;
       if(i>3){
         j++;
         i=0;
       }
       n++;
    }  
  }    
  color getCol(){
    colCount++;
    if (colCount>5) colCount=0;
    return colors[colCount];
  }  
}