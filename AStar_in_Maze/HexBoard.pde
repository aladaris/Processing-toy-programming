class HexBoard extends Board {
  HexAStarNode _cells[];

  HexBoard(final int xCount, final int yCount, final int cellWidth) {
    super(xCount, yCount);
    _cells = new HexAStarNode[xCount * yCount];
    
    for (int i = 0; i < xCount; i++) {
      for (int j = 0; j < yCount; j++) {
        _cells[i + (j * _width)] = new HexAStarNode(i, j, cellWidth, false);
      }
      
    }
    
    for (int i = 0; i < _cells.length; i++){
      _cells[i].addNeighbours(this);
    }
    
  }

  HexAStarNode getCell(final int idx) {
    if (idx < _cells.length){
      return _cells[idx];
    }
    return null;
  }
  
  HexAStarNode getCell (final int x, final int y){
    if ((x >= 0 && y >= 0)&&(x < _width && y < _height)){
      //return _cells[x + (y * _width)];
      return _cells[x + (y * _width)];
    }
    return null;
  }

  int getCellCount() { return _cells.length; }

  void show() {
      if (_cells.length > 0){
        final int cellWidth = _cells[0]._cellWidth;

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
            
            _cells[i + (j * _width)].show();
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