class BubleHandler extends Handler implements I_Handler{
  
  // Create an array of elements for a given size
  public BubleHandler(final int size){
    this();
    _elems = new int[size];
    for (int i = 0; i < size; i++)
      _elems[i] = (int)random(1024);
  }
  
  private BubleHandler(){
    _i = 1;
    _j = 0;
    end_j = false;
  }
  
  // // De momento sólo para I_element = Sqr
  // public void show(){
  //   //println("SHOW"); // DEBUG
  //   for (int i = 0; i < _elems.length; i++){
  //     _elems[i].paint();
  //     //print(_elems[i].position() + " ");  // DEBUG
  //   }
  // }

  public void show(){
    show(10, 10);
  }

  public boolean step(){
    // Calculate the indexes (_i and _j)
    if (_j + 1 < _elems.length - _i)
      _j++;
    else{
      _j = 0;
      end_j = true;
    }
    if (end_j){
      if (_i + 1 < size)
        _i++;
      else
        return false;
      end_j = false;
    }
    // Run one step of the algorithm
    selectedIndex = _j;
    if (_elems[_j] > _elems[_j+1]){
      int tmp = _elems[_j];
      _elems[_j] = _elems[_j+1];
      _elems[_j+1] = tmp;
    }
    return true;
  }
  
  public void run(){
    for (int i = 1; i < _elems.length; i++){
      for (int j = 0; j < _elems.length - i; j++){
        if (_elems[j] > _elems[j+1]){
          int tmp = _elems[j];
          _elems[j] = _elems[j+1];
          _elems[j+1] = tmp;
        }
      }
    }
    // Make sure that step() returns false (cant step anymore)
    end_j = true;
    _i = _elems.length;
  }

  // public boolean step(){
  //   // Calculate the indexes (_i and _j)
  //   if (_j + 1 < _elems.length - _i)
  //     _j++;
  //   else{
  //     _j = 0;
  //     end_j = true;
  //   }
  //   if (end_j){
  //     if (_i + 1 < size)
  //       _i++;
  //     else
  //       return false;
  //     end_j = false;
  //   }
  //   // Run one step of the algorithm
  //   if (_elems[_j].value() > _elems[_j+1].value()){
  //     int tmp = _elems[_j].value();
  //     _elems[_j].value(_elems[_j+1].value());
  //     _elems[_j+1].value(tmp);
  //   }
  //   return true;
  // }
 
  int _i;  // Iteration index for the algorithm
  int _j;  // Iteration index for the algorithm
  boolean end_j;  // True when _j gets to its higher value
  //private int maxValue; 
  //private int minValue;
};