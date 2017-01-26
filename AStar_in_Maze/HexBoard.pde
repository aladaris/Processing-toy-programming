class HexBoard extends Board {
  HexAStarNode _cells[][];
  int _cellCount;

  HexBoard(final int xCount, final int yCount, final int cellWidth) {
    super(xCount, yCount);
    _cells = new HexAStarNode[xCount][yCount];
    _cellCount = xCount * yCount;
    
    for (int i = 0; i < xCount; i++) {
      for (int j = 0; j < yCount; j++) {
        _cells[i][j] = new HexAStarNode(i, j, cellWidth, false);
      }
    }
    
    for (int y = 0; y < _height; y++) {
      for (int x = 0; x < _width/2; x++) {
        getCell(x, y).addNeighbours(this);
      }
    }

    
  }
  
  HexAStarNode getCell (final int x, final int y){
    if ((x >= 0 && y >= 0)&&(x < _width && y < _height)){
      
      if (y % 2 == 0){
        if (x * 2 < _width) {
          return _cells[x * 2][y];
        }
      } else {
        if (x * 2 + 1 < _width) {
          if (y - 1 >= 0){
            return _cells[x * 2 + 1][y - 1];
          } else {
            return _cells[x * 2 + 1][y];
          }
        }
      }
      
    }
    return null;
  }

  int getCellCount() { return _cellCount; }

  void show() {
      if (_cells.length > 0){
        final int cellWidth = _cells[0][0]._cellWidth;

        boolean evenCol = true;
        float deltaX = cellWidth * 3;
        float deltaY = cellWidth * 2;
        float displacementY;
        for (int i = 0; i < xCount; i++) {
          
          if (evenCol){
            deltaX = cellWidth * 3;
          } else {
            translate(-cellWidth/2, cellWidth);
            deltaX = cellWidth * 2;
          }
          
          translate(deltaX, 0);
          displacementY = 0;
          for (int j = 0; j < yCount; j++) {
            if (!evenCol){
              
            }
            
            translate(0, deltaY);
            displacementY += deltaY;
            
            _cells[i][j].show();
          }
          translate(0, -displacementY);
          if (evenCol){
          } else {
            translate(-(cellWidth + (cellWidth/2)), -cellWidth);
          }
          evenCol = !evenCol;
        }
      }
  }

}