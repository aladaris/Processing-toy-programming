//Board b;
HexBoard b;
AStar<HexAStarNode, HexBoard> aStar;

int xCount = 10;
int yCount = 10;
int cellSize = 20;

void setup(){
  size(901, 901);
  
  //b = new Board(xCount, yCount, 2);
  
  b = new HexBoard(xCount, yCount, cellSize);
  
  
  for (int i = 0; i < xCount; i++) {
      for (int j = 0; j < yCount; j++) {
        HexAStarNode node = b.getCell(i, j);
        if (node != null){
          for (ICell n : node.neighbours){
            if (random(1.0) < 0.60){
              node.removeWalls(n);
            }
          }
        }
      }
    }
  
  HexAStarNode initNode = b.getCell(3, 3);
  // DEBUG
  for (HexAStarNode n : initNode.neighbours){
    n.cellColor = color(0, 255, 255);
  }
  /*
  for (int i = 0; i < xCount; i++){
    HexAStarNode node = b.getCell(i, 1);
    if (node != null){
      node.cellColor = color(0,0,255);
    }
  }
  */
  
  aStar = new AStar(initNode, b.getCell(0, 0), b); //<>//
  
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