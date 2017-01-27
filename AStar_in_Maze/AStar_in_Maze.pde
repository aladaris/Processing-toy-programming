//Board b;
HexBoard b;
AStar<HexAStarNode, HexBoard> aStar;

int xCount = 77;
int yCount = 148;
int cellSize = 3;

void setup(){
  size(1393, 895);
  
  //b = new Board(xCount, yCount, 2);
  
  b = new HexBoard(xCount, yCount, cellSize);
  
  
  for (int i = 0; i < b._width; i++) {
      for (int j = 0; j < b._height; j++) {
        HexAStarNode node = b.getCell(i, j);
        if (node != null){
          for (ICell n : node.neighbours){
            if (random(1.0) < 0.2){
              node.removeWalls(n);
            }
          }
        }
      }
    }
  
  HexAStarNode initNode = b.getCell(2, 2);
  // DEBUG
  int inc = 0;
  for (ICell n : initNode.neighbours){
    n.cellColor = color(15+ inc, 150 + inc, 100 + inc);
    inc += 25;
  }

  /*
  for (int i = 0; i < xCount; i++){
    HexAStarNode node = b.getCell(i, 1);
    if (node != null){
      node.cellColor = color(0,0,255);
    }
  }
  */
  
  aStar = new AStar(initNode, b.getCell((int)random(xCount-1), (int)random(yCount-1)), b);
  
}

void draw(){
  background(0);
  if (!aStar.finished){
    aStar.advanceStep();
  }
  aStar.paintPath();
  b.show();
}