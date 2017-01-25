import java.util.Stack;

class QuickHandler extends Handler implements I_Handler{
  
  public QuickHandler(final int size){
    _elems = new int[size];
    for (int i = 0; i < size; i++)
      _elems[i] = (int)random(1024);
    _istck = new Stack<Integer>();
    _kstck = new Stack<Integer>();
    _pstck = new Stack<Integer>();
    _i = 0;
    _k = _elems.length - 1;
    _istck.push(_i);
    _kstck.push(_k);
  }
  
  public void show(){
    show(10, 10);
  }

  public void show(final int rows, final int cols){  // TODO: Pasar rows y cols como argumentos en el contructor y dejar esta función como la de la interface
    final int E_WIDTH = width / cols;
    final int E_HEIGHT = height / rows;
    noStroke();
    int curr_row = 0;
    int curr_col = 0;  // Current column
    for (int i = 0; i < _elems.length; i++){
      //println(i);  // DEBUG
      if (curr_col >= cols){
        curr_row++;
        curr_col = 0;
      }
      if (i == selectedIndex)
        fill(color(255,0,0));
      else if (i == _swapShow)
        fill(color(0,0,255));
      else if (( i == _leftShow) || (i == _rightShow))
        fill(color(150,0,200));
      else if (i == _pivotShow)
        fill(color(250,105,0));
      else
        fill(color(0.20 * _elems[i], 0.35 * _elems[i], 0.05 * _elems[i]));
      rect(curr_col * E_WIDTH, curr_row * E_HEIGHT, E_WIDTH, E_HEIGHT);
      curr_col++;
    }
  }
  
  private Stack<Integer> _istck;
  private Stack<Integer> _kstck;
  private Stack<Integer> _pstck;
  private boolean seguir1 = true;
  private boolean seguir2 = false;
  private int _i;
  private int _k;
  
  private boolean _partitionStart = true;
  private boolean _partitionRunning = false;
  private int _left;
  private int _right;
  private int _pIndex;
  private int _pValue;
  private int _sIndex;
  private int _pi;  // Partition Iterator
  private int _swapShow;
  private int _leftShow;
  private int _rightShow;
  private int _pivotShow;

  private void steppedPartition(){

    if (_partitionRunning){
      if (_pi <= _right - 1){
        if (_elems[_pi] <= _pValue){
          swap(_pi, _sIndex);
          selectedIndex = _sIndex;  // Show
          _swapShow = _pi;
          _sIndex++;
        }
        _pi++;
      }else{
        swap(_sIndex, _right);
        _partitionRunning = false;
        _partitionStart = false;  
      }
    }
  }

  public boolean step(){
    
    if (_partitionRunning){
      steppedPartition();
      return true;
    }
    
    if (seguir1){
      try{
        //println("Seguir 1");  // DEBUG
        int i = _istck.peek();
        int k = _kstck.peek();
        if (i < k){
          // Partition
          //int p = partition(i, k);
          if (_partitionStart){
            //println("new partition! ");  // DEBUG
            _left = i;
            _right = k;
            _leftShow = _left;
            _rightShow = _right;
            _pIndex = choosePivot(_left, _right);
            _pivotShow = _pIndex;
            _pValue = _elems[_pIndex];
            _pi = _left;
            swap(_pIndex, _right);
            _sIndex = _left;
            _partitionRunning = true;
            steppedPartition();
          }else{
            int p = _sIndex;
            selectedIndex = p;  // Show
            _pstck.push(p);
            _kstck.push(p - 1);
            _partitionStart = true;
          }
        }else{
          seguir1 = false;
          seguir2 = true;
          _kstck.pop();
        }
      }catch(Exception e){
        seguir1 = false;
        seguir2 = false;
        return false;
      }
    }

    
    if (seguir2){
      try{
        int i = _istck.pop();
        int p = _pstck.pop();
        selectedIndex = p;  // Show
        _istck.push(p + 1);
          seguir2 = false;
          seguir1 = true;
      }catch(Exception e){
        seguir1 = false;
        seguir2 = false;
        return false;
      }
    }
    return true;
  }
  
  public void run(){
    quickSort(0, _elems.length - 1);
  }

  private void quickSort(final int i, final int k){
    if (i < k){
      int p = partition(i, k);
      quickSort(i, p - 1);
      quickSort(p + 1, k);
    }
  }
  
  private int partition(final int left, final int right){
    int pIndex = choosePivot(left, right);
    int pValue = _elems[pIndex];
    swap(pIndex, right);
    int sIndex = left;

    for (int i = left; i <= right - 1; i++){
      if (_elems[i] <= pValue){
        swap(i, sIndex);
        selectedIndex = sIndex;  // Show
        sIndex++;
      }
    }
    swap(sIndex, right);
    return sIndex;
  }
  
  private int choosePivot(final int left, final int right){
    // return left + (right - left) / 2;  // Midpoint
    
    // Mid point among 1st, 2nd and last elements
    int first = _elems[left];
    int second = left + (right - left) / 2; //left + 1 < right ? _elems[left+1] : _elems[left];
    int last = right - 1 > left ? _elems[right - 1] : _elems[right];
    if ((second < first && first < last) || (last < first && first < second)){
      return left;
    } else if (( first < last && last < second) || (second < last && last < first )){
      return right - 1 > left ? right - 1 : right;
    } else { //if (( first < second && second < last) || (last < second && second < first )){
      return left + (right - left) / 2; //left + 1 < right ? left + 1 : left;
    }
  }

  private void swap(final int p1, final int p2){
    int tmp = _elems[p1];
    _elems[p1] = _elems[p2];
    _elems[p2] = tmp;
  }
  
};