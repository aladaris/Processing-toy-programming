//Board b;
HexBoard b;
AStar<HexAStarNode, HexBoard> aStar;

int xCount = 62;
int yCount = 49;
int cellSize = 9;

void setup(){
  size(901, 901);
  
  //b = new Board(xCount, yCount, 2);
  
  b = new HexBoard(xCount, yCount, cellSize);
  
  for (int i = 0; i < b.getCellCount(); i++){
    HexAStarNode node = b.getCell(i);

    for (ICell n : node.neighbours){
      if (random(1.0) < 0.001){
        node.removeWalls(n);
      }
    }
  }
  
  // DEBUG
  for (int i = 0; i < xCount; i++){
    b.getCell(i).cellColor = color(0,0,255);
  }
  
  aStar = new AStar(b.getCell(1, 0), b.getCell(xCount - 1,yCount - 1), b);
  
}

void draw(){
  //translate(0, 0);
  background(0);
  if (!aStar.finished){
    aStar.advanceStep();
  }
  aStar.paintPath();
  b.show();
}