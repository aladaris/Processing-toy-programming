enum CELL_TYPE { SQUARE, HEX };

class Board {
  ICell _cells[];
  int _width;
  int _height;
  CELL_TYPE _cellType;

  Board(final int xCount, final int yCount, final CELL_TYPE cellType) {
    _width = xCount;
    _height = yCount;
    _cellType = cellType;

    _cells = new ICell[xCount * yCount];
    for (int i = 0; i < xCount; i++) {
      for (int j = 0; j < yCount; j++) {
        switch(_cellType){
          case SQUARE:
            _cells[i + (j * _width)] = new CellSquare(i, j);
            break;
          case HEX:
            break;
            
        }
      }
    }
  }

  ICell getCell(final int idx) {
    if (idx < _cells.length){
      return _cells[idx];
    }
    return null;
  }
  
  ICell getCell (final int x, final int y){
    if ((x >= 0 && y >= 0)&&(x < _width && y < _height)){
      return _cells[x + (y * _width)];
    }
    return null;
  }
  
  ICell[] getCellNeighbours(final ICell cell, final int mazeGeneratorId){
    //if (xi < _width && yi < _height){
      //ICell cell = getCell(xi, yi);
      if (cell != null){
        ArrayList<ICell> neighbours = new ArrayList<ICell>();
        
        int x = cell.x;
        int y = cell.y - 1;
        addNeighbour(getCell(x, y), mazeGeneratorId, neighbours);
        
        x = cell.x + 1;
        y = cell.y;
        addNeighbour(getCell(x, y), mazeGeneratorId, neighbours);
        
        x = cell.x;
        y = cell.y + 1;
        addNeighbour(getCell(x, y), mazeGeneratorId, neighbours);
        
        x = cell.x - 1;
        y = cell.y;
        addNeighbour(getCell(x, y), mazeGeneratorId, neighbours);

        return neighbours.toArray(new ICell[neighbours.size()]);
      }
    //}
    return null;
  }

  int getCellCount() { return _cells.length; }

  void show() {
      translate(ICell.CELL_WIDTH, ICell.CELL_WIDTH);
      for (int i = 0; i < _cells.length; i++) {
        _cells[i].show();
      }
  }

  private void addNeighbour(final ICell cell, final int mazeGeneratorId, ArrayList<ICell> neighbours){
    if (cell != null){
      //ICell n = getCell(x, y);
      if (!cell.visited){
        neighbours.add(cell);
      } else if ((mazeGeneratorId >= 0)&&(cell.visitedBy != mazeGeneratorId)&&(random(1.0) < 0.015)){
        neighbours.add(cell);
      }
    }
  }
}