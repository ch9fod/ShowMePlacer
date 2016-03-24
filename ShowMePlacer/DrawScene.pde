class DrawScene { 
  PFont f;
  Button bStart,go,plSc2,mnSc2,back,pI,mI,pO,mO,createNet,clear,pStart;
  Grid gridL,gridR,gridBest;
  int blocks = 6;
  int I = 1;
  int O = 1;
  int sc3Bstate = 50;
  int sc3Ib = 10;
  int sc3Ob = 10;
  int scState = 0;
  String sNets = "";
  int iNets = 0;
  int defRectMode = CORNER;
  int curRectMode;
  float r;
  int b1=0, b2=0;  //blocks to exchange
  Nets[] nets = new Nets[100];
  IntList xS, yS;
  float T0 = 3500;
  float Tmin = 25;
  float alpha = 0.99;
  int best_cost;

  DrawScene() {  
    f = createFont("Arial", 18, true); 
    bStart = new Button(color(112, 173, 71), "Start!", width/2-100, height/2, 200, 100, 60);
    go = new Button(color(112, 173, 71), "GO", width/2-50, height/2+100, 100, 60, 50);
    plSc2 = new Button(color(112, 173, 71), "+", width/2+50, height/2-50, 40, 40, 35);
    mnSc2 = new Button(color(112, 173, 71), "-", width/2-90, height/2-50, 40, 40, 35);
    back = new Button(color(112, 173, 71), "Back", width/2+200, height/2+345, 85, 40, 30);
    pI = new Button(color(112, 173, 71), "+", width/2-290, height/2+95, 25, 20, 25);
    mI = new Button(color(112, 173, 71), "-", width/2-290, height/2-360, 25, 20, 25);
    pO = new Button(color(112, 173, 71), "+", width/2-35, height/2+95, 25, 20, 25);
    mO = new Button(color(112, 173, 71), "-", width/2-35, height/2-360, 25, 20, 25);
    createNet = new Button(color(112, 173, 71), "Create", width/2-290, height/2+120, 80, 30, 25);
    clear = new Button(color(112, 173, 71), "Clear", width/2-190, height/2+120, 80, 30, 25);
    pStart = new Button(color(112, 173, 71), "Start", width/2-90, height/2+120, 80, 30, 25);
    gridL = new Grid();
    gridR = new Grid();
    gridBest = new Grid();
    for(int i=0; i<nets.length; i++) {
        nets[i] = new Nets(i);
    }
    xS = new IntList();
    yS = new IntList();
  }
  void scene1() {
    curRectMode = CENTER;
    rectMode(curRectMode);
    fill(218, 227, 243);  
    rect(width/2, height/2, 600, 800);  
    textFont(f, 120); 
    fill(0);
    textAlign(CENTER, BOTTOM);
    text("ShowMe", width/2, height/3);
    textAlign(CENTER, TOP);
    text("Placer", width/2, height/3);
    curRectMode = defRectMode;
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
    textAlign(CENTER, TOP);
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
      if(blocks < 36){
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
    rect(width/2-290, height/2+160, 280, 220);
    back.Draw();
    createNet.Draw();
    clear.Draw();
    pStart.Draw();
    pI.Draw();
    mI.Draw();
    pO.Draw();
    mO.Draw();
    gridL.UpNDraw(blocks, I, O);
    clearAll();
  }  
  int sc3_CheckAndUpdate() {
    if (back.MouseIsOver()){
      scState = 1;
      scene2();
    }
    else if(pI.MouseIsOver()){
      if(I<9){
        I++;
        gridL.UpNDrawIO(I, O);
      }      
    }
    else if(mI.MouseIsOver()){
      if(I>0){
        I--;
        gridL.UpNDrawIO(I, O);
      }      
    }
    else if(pO.MouseIsOver()){
      if(O<9){
        O++;
        gridL.UpNDrawIO(I, O);
      }      
    }
    else if(mO.MouseIsOver()){
      if(O>0){
        O--;
        gridL.UpNDrawIO(I, O);
      }      
    }
    else if(createNet.MouseIsOver()){
      createNDispNet();
    }
    else if(pStart.MouseIsOver()){
      business();
    }
    else if(clear.MouseIsOver()){
      clearAll();
    }
    else{
      sc3Bstate = 50;  //reset buttons state
      sc3Ib = 10;  //reset buttons state
      sc3Ob = 10;  //reset buttons state
      for(int i=0; i<blocks; i++){
        if (gridL.snodes[i].MouseIsOver())
          sc3Bstate = i;
      }
      for(int i=0; i<I; i++){
        if (gridL.Is[i].MouseIsOver())
        sc3Ib = i;
      }
      for(int i=0; i<O; i++){
        if (gridL.Os[i].MouseIsOver())
         sc3Ob = i;
      }
      if (sc3Bstate!= 50)
        gridL.snodes[sc3Bstate].upButton(true);      
      if (sc3Ib!= 10)
       gridL.Is[sc3Ib].upButton(true);      
      if (sc3Ob!= 10)
       gridL.Os[sc3Ob].upButton(true);      
    }
    return scState;
  }
  void createNDispNet(){
    sNets = sNets + "net" + iNets + ":";
    for(int i=0; i<I; i++){
      if (gridL.Is[i].isSel()){
        if(sNets.charAt(sNets.length()-1) == ',' || sNets.charAt(sNets.length()-1) == ':')
          sNets = sNets + "I" + i;
        else
          sNets = sNets + "," + "I" + i;
        nets[iNets].attach('I',i);
      }
    }
    for(int i=0; i<O; i++){
      if (gridL.Os[i].isSel()){
        if(sNets.charAt(sNets.length()-1) == ',' || sNets.charAt(sNets.length()-1) == ':')
          sNets = sNets + "O" + i;
        else
          sNets = sNets + "," + "O" + i;
        nets[iNets].attach('O',i);
      }
    }
    for(int i=0; i<blocks; i++){
      if (gridL.snodes[i].isSel()){
        if(sNets.charAt(sNets.length()-1) == ',' || sNets.charAt(sNets.length()-1) == ':')
          sNets = sNets + i;
        else
          sNets = sNets + "," + i;
        nets[iNets].attach('N',i);
      }
    }
    sNets = sNets + "; ";
    unSelAll();
    rectMode(CORNER);
    fill(124, 124, 124);
    rect(width/2-290, height/2+160, 280, 220);    
    textAlign(LEFT);
    textFont(f, 12);
    fill(0);
    text(sNets, width/2-290, height/2+160, 280, 220);     
    iNets++;    
  }
  void unSelAll(){
    for(int i=0; i<blocks; i++){
      gridL.snodes[i].upButton(false);
    }
    for(int i=0; i<I; i++){
      gridL.Is[i].upButton(false);
    }
    for(int i=0; i<O; i++){
      gridL.Os[i].upButton(false);
    }
  }
  void clearAll(){
    sNets = "";
    iNets = 0;
    unSelAll();  
    for(int i=0; i<nets.length; i++){
      nets[i].clearNet();
    }
    rectMode(CORNER);
    fill(124, 124, 124);
    rect(width/2-290, height/2+160, 280, 220);
  }  
  void business(){
    //int promedio=0;
    float T;
    int k = 0;
    int curr_cost;
    int trial_cost;
    int ch_cost;
    gridR = gridL;
    gridR.UpInitials(300);
    gridBest = gridR;
    T = T0;
    curr_cost = Lcost();
    best_cost = curr_cost;
    while(T > Tmin){
      //ADD STOP BUTTON HERE?
      k++;
      XchangeX(false);
      trial_cost = Lcost();
      ch_cost = trial_cost - curr_cost;
      if(ch_cost <= 0){        
        curr_cost = trial_cost;
        println("current cost =",curr_cost,"iteration =",k);
        if(curr_cost < best_cost){
          best_cost = curr_cost;
          gridBest = gridR;
        }
      }
      else{
        r = random(0,1);
        if(r < exp(-ch_cost/T)){
          curr_cost = trial_cost;
          println("bad term ACCEPTED","r =",r,"temp =",T,"exp =",exp(-ch_cost/T),"bad cost =",curr_cost,"iteration =",k);
        }
        else{
          XchangeX(true);
          println("bad term REJECTED","r=",r,"temp=",T,"exp=",exp(-ch_cost/T),"bad cost=",curr_cost,"iteration=",k);
        }
      }
    T = T * alpha;  
    }
    println("total iterations =",k,"last cost =",curr_cost);
  }  
  void XchangeX(boolean back){
    int xt, yt;
    if(back){
      //print(b1,b2);print(" Back ");
      xt = gridR.snodes[b1].x0m;
      yt = gridR.snodes[b1].y0m;
      gridR.snodes[b1].UpLoc(gridR.snodes[b2].x0m,gridR.snodes[b2].y0m);
      gridR.snodes[b2].UpLoc(xt,yt);  
      gridR.snodes[b1].Draw(f);
      gridR.snodes[b2].Draw(f);      
    }
    else{
      b1 = int(random(-1,blocks));
      b2 = int(random(-1,blocks));
      if(b1 == b2){
        if(b2 == blocks-1)
          b1--;
        else
          b2++;
      }
      //print(b1,b2);print("  ");
      xt = gridR.snodes[b1].x0m;
      yt = gridR.snodes[b1].y0m;
      gridR.snodes[b1].UpLoc(gridR.snodes[b2].x0m,gridR.snodes[b2].y0m);
      gridR.snodes[b2].UpLoc(xt,yt);  
      gridR.snodes[b1].Draw(f);
      gridR.snodes[b2].Draw(f);
    }
  }
  int Lcost(){
    int cost = 0;
    for(int i=0; i<nets.length; i++) {
      if(nets[i].en){
        if(nets[i].Is.size()>0){
          for(int j=0;j<nets[i].Is.size();j++){
            xS.append(gridR.Is[nets[i].Is.get(j)].x0m);
            yS.append(gridR.Is[nets[i].Is.get(j)].y0m);
            //print('I',nets[i].Is.get(j));print(" ");print(gridR.Is[nets[i].Is.get(j)].x0m);print(" ");print(gridR.Is[nets[i].Is.get(j)].y0m);print(" ");
          }
        }
        if(nets[i].Os.size()>0){
          for(int j=0;j<nets[i].Os.size();j++){
            xS.append(gridR.Os[nets[i].Os.get(j)].x0m);
            yS.append(gridR.Os[nets[i].Os.get(j)].y0m);
            //print('O',nets[i].Os.get(j));print(" ");print(gridR.Os[nets[i].Os.get(j)].x0m);print(" ");print(gridR.Os[nets[i].Os.get(j)].y0m);print(" ");
          }
        }
        if(nets[i].nodes.size()>0){
          for(int j=0;j<nets[i].nodes.size();j++){
            xS.append(gridR.snodes[nets[i].nodes.get(j)].x0m);
            yS.append(gridR.snodes[nets[i].nodes.get(j)].y0m);
            //print('N',nets[i].nodes.get(j));print(" ");print(gridR.snodes[nets[i].nodes.get(j)].x0m);print(" ");print(gridR.snodes[nets[i].nodes.get(j)].y0m);print(" ");
          }
        }
      }
      if(xS.size()>0){
        cost = cost + abs(xS.max()-xS.min()) + abs(yS.max()-yS.min());
        xS.clear();yS.clear();
        //print(cost);
        //print('\n');
      }
    }
    return cost;
  }
  //void printNets(){
  //  for(int i=0; i<nets.length; i++){
  //    if(nets[i].en)
  //      nets[i].printAll();
  //  }  
  //}
}