class Nets { //Nets class.
  int id,iIs=0,iOs=0,iN=0;    
  IntList Is, Os, nodes;
  boolean en = false;
  Nets(int ID) {
    id = ID;
    Is = new IntList();
    Os = new IntList();
    nodes = new IntList();
  }
  void attach(char Type, int Value){
    en = true;
    if(Type == 'I'){
      Is.append(Value);
      iIs++;
    }
    else if(Type == 'O'){
      Os.append(Value);
      iOs++;
    }
    else if(Type == 'N'){
      nodes.append(Value);
      iN++;
    }
  }
  void printAll(){
    if(iIs != 0){ 
      for(int i=0; i<iIs; i++){
        println(Is.get(i));      
      }
    }
    if(iOs != 0){
      for(int i=0; i<iOs; i++){
        println(Os.get(i));        
      }
    }
    if(iN != 0){
      for(int i=0; i<iN; i++){
        println(nodes.get(i));        
      }
    }
  }
  void clearNet(){
    en = false;
    iIs = 0;
    iOs = 0;
    iN = 0;
    Is.clear();
    Os.clear();
    nodes.clear();
  }  
}