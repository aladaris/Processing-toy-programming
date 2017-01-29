//Board b;
HexBoard b;
AStar<HexAStarNode, HexBoard> aStar;

int xCount = 25;
int yCount = 20;
int cellSize = 5;

void setup(){
  size(1393, 895);
  
  //b = new Board(xCount, yCount, 2);
  
  b = new HexBoard(xCount, yCount, cellSize);
  
  
  for (int i = 0; i < b._width; i++) {
      for (int j = 0; j < b._height; j++) {
        HexAStarNode node = b.getCell(i, j);
        if (node != null){
          for (ICell n : node.neighbours){
            if (random(1.0) < 0.45){
              node.removeWalls(n);
            }
          }
        }
      }
    }
    
    for (int i = 0; i < b._width; i++) {
      for (int j = 0; j < b._height; j++) {
        HexAStarNode node = b.getCell(i, j);
        if (node.allWalls()){
          node.cellColor = color(255);
          println("ALL WALLS");  // DEBUG
        }
      }
    }
  
  HexAStarNode initNode = b.getCell(0, 0);  
  aStar = new AStar(initNode, b.getCell((int)random(xCount-1), (int)random(yCount-1)), b);
  
}

void draw(){
  background(0);
  aStar.paintPath();
  b.show();
  if (!aStar.finished){
    aStar.advanceStep();
  } else {
    noLoop();
  }
  
  final String txt_fps = String.format(getClass().getName()+ "   [fps %6.2f]", frameRate);
  surface.setTitle(txt_fps);
}