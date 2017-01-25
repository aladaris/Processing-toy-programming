MazeGenerator mg;
MazeGenerator generators[];
ArrayList<Integer> startingCells = new ArrayList<Integer>();

void setup(){
  size(901, 901);
  
  mg = new MazeGenerator(0, 150, 150, CELL_TYPE.SQUARE);
  generators = new MazeGenerator[200];
  for (int i = 0; i < generators.length; i++){
    int startingCell = (int)random(mg.board.getCellCount());
    while (startingCells.contains(startingCell)){
      startingCell = (int)random(mg.board.getCellCount());
    }
    startingCells.add(startingCell);
    generators[i] = new MazeGenerator(i + 1, mg.board, startingCell);
  }

}

void draw(){
  background(0);
  
  mg.advanceStep();
  
  boolean allFinished = mg.processFinished;
  for (int i = 0; i < generators.length; i++){
    generators[i].advanceStep();
    allFinished = allFinished && generators[i].processFinished;
  }
  mg.drawBoard();

  if (allFinished){
    noLoop();
    println("All MazeGenerators: DONE! ");
  }

  
  
  final String txt_fps = String.format(getClass().getName()+ "   [fps %6.2f]", frameRate);
  surface.setTitle(txt_fps);
}