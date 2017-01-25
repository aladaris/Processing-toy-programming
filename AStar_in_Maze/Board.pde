class Board {
  AStarNode _cells[];
  int _width;
  int _height;
  
  Board(final int xCount, final int yCount){
     _width = xCount;
    _height = yCount;
  }

  Board(final int xCount, final int yCount, final int cellWidth) {
    _width = xCount;
    _height = yCount;

    _cells = new AStarNode[xCount * yCount];
    for (int i = 0; i < xCount; i++) {
      for (int j = 0; j < yCount; j++) {
        _cells[i + (j * _width)] = new AStarNode(i, j, cellWidth);
      }
    }
    
    for (int i = 0; i < _cells.length; i++){
      _cells[i].addNeighbours(this);
    }
    
  }

  AStarNode getCell(final int idx) {
    if (idx < _cells.length){
      return _cells[idx];
    }
    return null;
  }
  
  AStarNode getCell (final int x, final int y){
    if ((x >= 0 && y >= 0)&&(x < _width && y < _height)){
      return _cells[x + (y * _width)];
    }
    return null;
  }

  int getCellCount() { return _cells.length; }

  void show() {
      if (_cells.length > 0){
        for (int i = 0; i < _cells.length; i++) {
          _cells[i].show();
        }
      }
  }

}