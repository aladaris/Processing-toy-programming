abstract class ICell {
  public static final int CELL_WIDTH = 3;  // TODO: Make this setteable
  
  public int x;
  public int y;
  public boolean visited;
  public boolean current;
  public boolean[] walls;
  public int visitedBy;
  
  
  public abstract void show();
  public abstract void removeWalls(final ICell neighbour);
}