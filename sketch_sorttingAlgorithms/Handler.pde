class Handler{

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
      else
        fill(color(0.20 * _elems[i], 0.35 * _elems[i], 0.05 * _elems[i]));
      rect(curr_col * E_WIDTH, curr_row * E_HEIGHT, E_WIDTH, E_HEIGHT);
      curr_col++;
    }
  }

  protected int selectedIndex;
  protected int[] _elems;
};
