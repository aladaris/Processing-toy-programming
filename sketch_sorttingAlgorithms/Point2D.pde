class Point2D{
  
  public Point2D(final int i_x, final int i_y){
    x = i_x;
    y = i_y;
  }
  
  @Override
  public String toString() {
    return "[" + x + ", " + y + "]";
  }
  
  public int x;
  public int y;
};
