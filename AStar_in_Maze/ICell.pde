abstract class ICell {
  //public static final int CELL_WIDTH = 10;  // TODO: Make this setteable
  
  protected PVector _pos;
  
  public int x;
  public int y;
  public boolean[] walls;
  
  public color cellColor;
  
  public abstract void show();
  public abstract void removeWalls(final ICell neighbour);
  //public abstract boolean isWallBetweenCell(final ICell neighbour);
  public abstract int getCellWidth();
  
  //public abstract int hashCode();
  //public abstract boolean equals(Object o);
  
}