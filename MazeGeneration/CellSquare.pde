class CellSquare extends ICell {
  private PVector _pos;

  public CellSquare(int xi, int yi){
    x = xi;
    y = yi;
    visited = false;
    current = false;
    _pos = new PVector(x * (2 * CellSquare.CELL_WIDTH), y * (2 * CellSquare.CELL_WIDTH));
    walls = new boolean[4];  // Top, Right, Bottom, Left
    walls[0] = walls[1] = walls[2] = walls[3] = true;
    // Disable redundant borders
    walls[0]  = y == 0 ? true :false;
    walls[3] = x == 0 ? true : false;
  }
  
  @Override
  public void show(){
    final int w = CELL_WIDTH;

    boolean draw = false;

    if (visited){
      noStroke();
      fill(230, 15, 110);
      rectMode(RADIUS);
      rect(_pos.x, _pos.y, CELL_WIDTH, CELL_WIDTH);
      draw = true;
    }
    if (current){
      noStroke();
      fill(180, 180, 180);
      rectMode(RADIUS);
      rect(_pos.x, _pos.y, CELL_WIDTH, CELL_WIDTH);
      draw = true;
    }

    if (draw){
      noFill();
      stroke(0);
      strokeWeight(2);
      //ellipse(_pos.x, _pos.y, 0.5, 0.5);  // CENTER (DEBUG)
      if (walls[0])
        line(_pos.x  - w, _pos.y - w, _pos.x + w, _pos.y - w);  // UP
      if (walls[1])
        line(_pos.x  + w, _pos.y - w, _pos.x + w, _pos.y + w);  // RIGHT
      if (walls[2])
        line(_pos.x  + w, _pos.y + w, _pos.x - w, _pos.y + w);  // BOTTOM
      if (walls[3])
        line(_pos.x  - w, _pos.y + w, _pos.x - w, _pos.y - w);  // LEFT
    }
  }
  
  // STATIC
  
  @Override
  public void removeWalls(final ICell neighbour){
    CellSquare sqBour = (CellSquare)neighbour;
    if (this.x == sqBour.x && this.y - 1 == sqBour.y){  // TOP neighbour
      this.walls[0] = false;
      sqBour.walls[2] = false;
    } else if (this.x + 1 == sqBour.x && this.y == sqBour.y){  // RIGHT neighbour
      this.walls[1] = false;
      sqBour.walls[3] = false;
    } else if (this.x == sqBour.x && this.y + 1 == sqBour.y){  // BOTTOM neighbour
      this.walls[2] = false;
      sqBour.walls[0] = false;
    } else if (this.x - 1 == sqBour.x && this.y == sqBour.y){  // LEFT neighbour
      this.walls[3] = false;
      sqBour.walls[1] = false;
    }
  }
  
}