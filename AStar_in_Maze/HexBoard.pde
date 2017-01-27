class HexBoard extends Board {
  HexAStarNode _cells[][];
  int _cellCount;

  HexBoard(final int xCount, final int yCount, final int cellWidth) {
    super(xCount, yCount);
    _cells = new HexAStarNode[_width][_height];
    _cellCount = _width * _height;
    
    for (int i = 0; i < _width; i++) {
      for (int j = 0; j < _height; j++) {
        _cells[i][j] = new HexAStarNode(i, j, cellWidth);
      }
    }
    
    for (int y = 0; y < _height; y++) {
      for (int x = 0; x < _width; x++) {
        getCell(x, y).addNeighbours(this);
      }
    }

    
  }
  
  HexAStarNode getCell (final int x, final int y){   
    if ((x >= 0 && y >= 0)&&(x < _width && y < _height)){
      return _cells[x][y];
    }
    
    return null;
  }

  int getCellCount() { return _cellCount; }

  void show() {
    if (_cells.length > 0){
      final int cellWidth = _cells[0][0]._cellWidth;
      boolean evenRow = true;
      
      pushMatrix();
      translate(-cellWidth * 2, cellWidth * 3);
      for (int y = 0; y < _height; y++){
        evenRow = (y % 2) == 0;
        if (evenRow){
          translate(0, -cellWidth*2);
        } else {
          translate(cellWidth * 1.5, -cellWidth);
        }
        for (int x = 0; x < _width; x++){
          translate(cellWidth * 3, 0);
          _cells[x][y].show();

        }
        if (evenRow){
          translate(-(cellWidth * 3 * _width), cellWidth * 2);
        } else {
          translate(-((cellWidth * 3 * _width)+(cellWidth * 1.5)), cellWidth * 3);
        }
      }
      popMatrix();
      
    }
      /*
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
      */
  }

}