class MazeGenerator{
  int id;
  Board board;
  ICell current;
  int visitedCount;
  boolean processFinished;
  java.util.Stack<ICell> stack;
  
  public MazeGenerator(final int id, final int xCount, final int yCount, final CELL_TYPE cellType) {
    this.id = id;
    board = new Board(xCount, yCount, cellType);
    current = board.getCell(0);
    visitedCount = 1;
    stack = new java.util.Stack<ICell>();
    processFinished = false;
  }
  
  public MazeGenerator(final int id, Board b, final int initialCell){
    this.id = id;
    board = b;
    current = board.getCell(initialCell);
    current.visited = true;
    visitedCount = 0;
    stack = new java.util.Stack<ICell>();
    processFinished = false;
  }
  
  public void advanceStep(){
    current.visited = true;
    current.visitedBy = this.id;
    if ((visitedCount < board.getCellCount())&&(!processFinished)){
      ICell[] neighbours = board.getCellNeighbours(current, this.id);
      if (neighbours != null && neighbours.length > 0){
        ICell nbour = neighbours[(int)random(neighbours.length)];
        stack.push(current);
        current.removeWalls(nbour);
        current.current = false;  // Just for display
        current = nbour;
        visitedCount++;
      } else if (!stack.isEmpty()) {
        current = stack.pop();
      } else {
        processFinished = true;
        println("MazeGenerator: Process Finished", this.id);
      }
      current.current = true;  // Just for display
    }/* else {
      noLoop();
      println("MazeGenerator: DONE!");
    }*/
  }
  
  public void drawBoard(){
    board.show();
  }
  
}