class DrawScene {// this class handles everything on the program. Nodes, nets, buttons, inputs. 
  String demoNet = "net0:I0,2; net1:I1,6; net2:I2,10; net3:I3,14; net4:I4,18; net5:I5,22; net6:I6,26; net7:I7,30; net8:I8,34; net9:O0,1; net10:O1,5; net11:O2,9; net12:O3,13; net13:O4,17; net14:O5,21; net15:O6,25; net16:O7,29; net17:O8,33; net18:0,3; net19:4,7; net20:8,11; net21:12,15; net22:16,19; net23:20,23; net24:24,27; net25:28,31; net26:32,35;"; 
  PFont f;
  Button bStart,go,plSc2,mnSc2,back,pI,mI,pO,mO,createNet,clear,pStart,demo;
  TInput Ttemp, Tdecay, TImin;
  Grid gridL;  // class for grid of blocks and IOs
  int blocks = 6;  //initial blocks number
  int I = 1;      // initial Inputs number
  int O = 1;      // initial outputs numbet
  int sc3Bstate = 50; // control state
  int sc3Ib = 10;     // maximun number of inputs
  int sc3Ob = 10;    // maximun number of outputs
  int scState = 0;    // states
  String sNets = ""; // nets label
  int iNets = 0;      // number of nets
  int defRectMode = CORNER;
  int curRectMode;
  float r;  // used for simulated annealing algorithm
  int b1=0, b2=0;  //blocks to exchange
  Nets[] nets = new Nets[100]; 
  IntList xS, yS;
  float T0 = 5000; // used for simulated annealing algorithm
  float Tmin = 5; // used for simulated annealing algorithm
  float alpha = 0.99; // used for simulated annealing algorithm
  int best_cost, curr_cost, initial_cost; // used for simulated annealing algorithm
  boolean started = false;

  DrawScene() {  //class constructor
    f = createFont("Arial", 18, true);
    ///////////////////////////////buttons/////////////////////////////////////////////////////
    bStart = new Button(color(112, 173, 71), "Start!", width/2-100, height/2, 200, 100, 60);
    go = new Button(color(112, 173, 71), "GO", width/2-120, height/2+50, 100, 60, 50);
    demo = new Button(color(112, 173, 71), "Demo", width/2, height/2+50, 140, 60, 50);
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
    /////////////////////////Text inputs/////////////////////////////////////////////////////////
    Ttemp = new TInput("T0:", str(T0), width/2-260, height/2-395, 100, 25, 20, 7);
    TImin = new TInput("Tmin:", str(Tmin), width/2, height/2-395, 60, 25, 20, 4);
    Tdecay = new TInput("Decay:", str(alpha), width/2+200, height/2-395, 80, 25, 20, 5);
    ////////////////////////////////////////////////////////////////////////////////////////////
    gridL = new Grid();  // grid class contructor
    for(int i=0; i<nets.length; i++) {
        nets[i] = new Nets(i); //nets class constructor
    }
    xS = new IntList();
    yS = new IntList();
  }
  void scene1() { //draws scene1
    String disc = "ShowMe Placer IS NOT A GAME. This is a visualization program. It uses Simulated Annealing to create an optimized placement. It starts from an inicial placement and a netlist the user creates. \n\nLIMITATIONS: \n  -The maximun of blocks is 36. \n  -Each node has a maximun of 3 blocks(IOs or blocks). \n  -The demo button creates a netlist for you with 36 blocks.";
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
    textAlign(LEFT);
    rectMode(CENTER);
    textFont(f, 20);     
    text("Disclaimer:", width/2-290, height/2+150);
    text(disc, width/2, height/2+360, 585, 400);     
  }
  int sc1_CheckAndUpdate() {  //checks buttons start
    if(bStart.MouseIsOver()){
      scState = 1;
      scene2();
    }      
    return scState;
  }
  void scene2() {//draws scene2
    String inst = "Use mouse clicks to create connections between blocks. Available spots for connections are visual dots on the middle of blocks. Use the + and – buttons to add external IO that can be used to connect blocks as well. This IO blocks are static. Since this program use simulated annealing to do the placement, you can also edit the algorithm variables like temperatures and decay. For this, you have to click to edit and click to finish editing. Press the demo button to use a 36 blocks, 18 IOs and a netlist pre-created for demo purposes. Press Start for begin placing. Clear to start over. To come back to this screen, use the back button.";
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
    text("Instructions:", width/2-292, height/2+145);
    textFont(f, 18); 
    text(inst, width/2, height/2+350, 585, 400);    
    go.Draw();
    demo.Draw();
    plSc2.Draw();
    mnSc2.Draw();    
  }
  int sc2_CheckAndUpdate() {  //checks buttons on scene2
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
    else if(demo.MouseIsOver()){
      scState = 2;
      blocks = 36;
      I = 9;
      O = 9;
      scene3();
      createNDemo();
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
  void scene3() { //draws scene 3
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
    Ttemp.DrawRec(false);
    Ttemp.DrawLabel();
    Tdecay.DrawRec(false);
    Tdecay.DrawLabel();
    TImin.DrawRec(false);
    TImin.DrawLabel();
    gridL.UpNDraw(blocks, I, O);
    clearAll();
  }  
  int sc3_CheckAndUpdate() { //checks all buttons on scene3
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
    else if(Ttemp.MouseIsOver()){
      if(!Tdecay.IsEn() && !TImin.IsEn())
        Ttemp.Toogle();
    }
    else if(Tdecay.MouseIsOver()){
      if(!Ttemp.IsEn() && !TImin.IsEn())
        Tdecay.Toogle();
    }
    else if(TImin.MouseIsOver()){
      if(!Ttemp.IsEn() && !Tdecay.IsEn())
        TImin.Toogle();
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
  void createNDispNet(){ //creates nets with the create button
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
    text(sNets, width/2-285, height/2+160, 275, 220);     
    iNets++;    
  }
  void createNDemo(){ //creates demo netlist
      nets[0].attach('I',0);  nets[0].attach('N',2);
      nets[1].attach('I',1);  nets[1].attach('N',6);
      nets[2].attach('I',2);  nets[2].attach('N',10);
      nets[3].attach('I',3);  nets[3].attach('N',14);
      nets[4].attach('I',4);  nets[4].attach('N',18);
      nets[5].attach('I',5);  nets[5].attach('N',22);
      nets[6].attach('I',6);  nets[6].attach('N',26);
      nets[7].attach('I',7);  nets[7].attach('N',30);
      nets[8].attach('I',8);  nets[8].attach('N',34);
      nets[9].attach('O',0);  nets[9].attach('N',1);
      nets[10].attach('O',1); nets[10].attach('N',5);
      nets[11].attach('O',2); nets[11].attach('N',9);
      nets[12].attach('O',3); nets[12].attach('N',13);
      nets[13].attach('O',4); nets[13].attach('N',17);
      nets[14].attach('O',5); nets[14].attach('N',21);
      nets[15].attach('O',6); nets[15].attach('N',25);
      nets[16].attach('O',7); nets[16].attach('N',29);
      nets[17].attach('O',8); nets[17].attach('N',33);
      nets[18].attach('N',0); nets[18].attach('N',3);
      nets[19].attach('N',4); nets[19].attach('N',7);
      nets[20].attach('N',8); nets[20].attach('N',11);
      nets[21].attach('N',12);nets[21].attach('N',15);
      nets[22].attach('N',16);nets[22].attach('N',19);
      nets[23].attach('N',20);nets[23].attach('N',23);
      nets[24].attach('N',24);nets[24].attach('N',27);
      nets[25].attach('N',28);nets[25].attach('N',31);
      nets[26].attach('N',32);nets[26].attach('N',35);
      rectMode(CORNER);
      fill(124, 124, 124);
      rect(width/2-290, height/2+160, 280, 220);    
      textAlign(LEFT);
      textFont(f, 12);
      fill(0);
      text(demoNet, width/2-285, height/2+160, 275, 220);         
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
  void clearAll(){ //clears for new netlist
    sNets = "";
    iNets = 0;
    unSelAll();  
    for(int i=0; i<nets.length; i++){
      nets[i].clearNet();
    }
    if(started){
      gridL.Reset();
      gridL.UpNDraw(blocks, I, O);
    }
    rectMode(CORNER);
    fill(124, 124, 124);
    rect(width/2-290, height/2+160, 280, 220);
    fill(237, 237, 237);
    rect(width/2+5, height/2-360, 290, 750);
    back.Draw();
  }  
  void business(){ //here we have the simulated annealig algorithm
    started = true;
    float T;
    int k = 0;
    int trial_cost;
    int ch_cost;
    int bad_moves = 0;
    gridL.UpInitials(300);
    T = T0;
    curr_cost = Lcost();
    initial_cost = curr_cost;
    best_cost = curr_cost;
    while(T > Tmin){
      //ADD STOP BUTTON HERE?
      k++;
      XchangeX(false);
      trial_cost = Lcost();
      ch_cost = trial_cost - curr_cost;
      if(ch_cost <= 0){        
        curr_cost = trial_cost; //best new cost
        println("current cost =",curr_cost,"iteration =",k);
        if(curr_cost < best_cost){
          best_cost = curr_cost;
        }
      }
      else{
        //here its the part where it accepts bad moves
        r = random(0,1);
        if(r < exp(-ch_cost/T)){
          curr_cost = trial_cost;
          bad_moves++;
          println("bad term ACCEPTED","r =",r,"temp =",T,"exp =",exp(-ch_cost/T),"bad cost =",curr_cost,"iteration =",k);
        }
        else{
          XchangeX(true);
          println("bad term REJECTED","r =",r,"temp=",T,"exp =",exp(-ch_cost/T),"bad cost =",curr_cost,"iteration =",k);
        }
      }
    T = T * alpha;  
    }
    println("total iterations =",k,"last cost =",curr_cost);
    DrawEnd(k, bad_moves);
  }  
  void XchangeX(boolean back){
    int xt, yt;
    if(back){
      xt = gridL.snodes[b1].x0m;
      yt = gridL.snodes[b1].y0m;
      gridL.snodes[b1].UpLoc(gridL.snodes[b2].x0m,gridL.snodes[b2].y0m);
      gridL.snodes[b2].UpLoc(xt,yt);  
      gridL.snodes[b1].Draw(f);
      gridL.snodes[b2].Draw(f);      
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
      xt = gridL.snodes[b1].x0m;
      yt = gridL.snodes[b1].y0m;
      gridL.snodes[b1].UpLoc(gridL.snodes[b2].x0m,gridL.snodes[b2].y0m);
      gridL.snodes[b2].UpLoc(xt,yt);  
      gridL.snodes[b1].Draw(f);
      gridL.snodes[b2].Draw(f);
    }
  }
  int Lcost(){ // calculates total cost
    int cost = 0;
    for(int i=0; i<nets.length; i++) {
      if(nets[i].en){
        if(nets[i].Is.size()>0){
          for(int j=0;j<nets[i].Is.size();j++){
            xS.append(gridL.Is[nets[i].Is.get(j)].x0m);
            yS.append(gridL.Is[nets[i].Is.get(j)].y0m);
          }
        }
        if(nets[i].Os.size()>0){
          for(int j=0;j<nets[i].Os.size();j++){
            xS.append(gridL.Os[nets[i].Os.get(j)].x0m);
            yS.append(gridL.Os[nets[i].Os.get(j)].y0m);
          }
        }
        if(nets[i].nodes.size()>0){
          for(int j=0;j<nets[i].nodes.size();j++){
            xS.append(gridL.snodes[nets[i].nodes.get(j)].x0m);
            yS.append(gridL.snodes[nets[i].nodes.get(j)].y0m);
          }
        }
      }
      if(xS.size()>0){
        cost = cost + abs(xS.max()-xS.min()) + abs(yS.max()-yS.min());
        xS.clear();yS.clear();
      }
    }
    return cost;
  }
  void CheckKey(){
    if(Ttemp.IsEn()){
      T0 = Ttemp.Update();
    }
    if(Tdecay.IsEn()){
      alpha = Tdecay.Update();
    }
    if(TImin.IsEn()){
      Tmin = TImin.Update();
    }
  }
  void DrawEnd(int it, int bad){
    String fInfo;
    fInfo = "Initial cost = " + initial_cost + "\n" + 
            "Final cost = " + curr_cost + "\n" + 
            "Iterations = " + it + "\n" + 
            "Bad moves = " + bad;
    fill(0);  
    textAlign(CENTER, TOP);
    textFont(f, 50); 
    text("Done!", width/2+145, height/2+90);
    rectMode(CORNER);
    textAlign(CENTER);
    textFont(f, 25); 
    text(fInfo, width/2+10, height/2+150, 290, 500);
  }
}