import java.util.*;

class AStarNode extends ICell {
  protected final int _cellWidth;
  
  public double f_score = 0.0;
  public double g_score = 0.0;
  public double h_score = 0.0;
  public List<AStarNode> neighbours;
  public AStarNode cameFrom;

  public AStarNode(final int xi, final int yi, final int cellWidth){
    this.x = xi;
    this.y = yi;
    this._cellWidth = cellWidth;
    this.cameFrom = null;
    this.cellColor = -1;
    this.neighbours = new ArrayList<AStarNode>();
    
    _pos = new PVector(x * (2 * _cellWidth), y * (2 * _cellWidth));
    walls = new boolean[4];  // Top, Right, Bottom, Left
    walls[0] = walls[1] = walls[2] = walls[3] = true;
    // Disable redundant borders
    walls[0] = y == 0 ? true : false;
    walls[3] = x == 0 ? true : false;
  }
  
  public float getDistance(ICell cell){
    if (cell != null)
      return dist(this._pos.x, this._pos.y, cell._pos.x, cell._pos.y);
    return MAX_FLOAT;
  }
  
  public void addNeighbours(final Board board){
    if (board != null){
      
      int x = this.x;
      int y = this.y - 1;
      AStarNode node = board.getCell(x, y);
      if (node != null){
        neighbours.add(node);  // TOP
      }
      
      x = this.x + 1;
      y = this.y;
      node = board.getCell(x, y);
      if (node != null){
        neighbours.add(node);  // RIGHT
      }

      x = this.x;
      y = this.y + 1;
      node = board.getCell(x, y);
      if (node != null){
        neighbours.add(node);  // BOTTOM
      }
      
      x = this.x - 1;
      y = this.y;
      node = board.getCell(x, y);  // LEFT
      if (node != null){
        neighbours.add(node);
      }
    }
  }
  
  @Override
  public void show(){
    final int w = _cellWidth;

    if (cellColor != -1){
      noStroke();
      fill(color(cellColor, 120));
      rectMode(RADIUS);
      rect(_pos.x, _pos.y, _cellWidth, _cellWidth);
    }
    
    noFill();
    stroke(255);
    strokeWeight(1);
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
  
  @Override
  public void removeWalls(final ICell neighbour){
    AStarNode sqBour = (AStarNode)neighbour;
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

  public boolean isWallBetweenCell(final AStarNode neighbour){
    
    if (this.x == neighbour.x && this.y - 1 == neighbour.y){  // TOP neighbour
      if ((this.walls[0] == false)&&(this.walls[0] == neighbour.walls[2])){
        return false;
      }
    } else if (this.x + 1 == neighbour.x && this.y == neighbour.y){  // RIGHT neighbour
      if ((this.walls[1] == false)&&(this.walls[1] == neighbour.walls[3])){
        return false;
      }
    } else if (this.x == neighbour.x && this.y + 1 == neighbour.y){  // BOTTOM neighbour
      if ((this.walls[2] == false)&&(this.walls[2] == neighbour.walls[0])){
        return false;
      }
    } else if (this.x - 1 == neighbour.x && this.y == neighbour.y){  // LEFT neighbour
      if ((this.walls[3] == false)&&(this.walls[3] == neighbour.walls[1])){
        return false;
      }
    }
    
    /*
    if ((this.x == sqBour.x && this.y - 1 == sqBour.y) ||
        (this.x == sqBour.x && this.y + 1 == sqBour.y)) {  // TOP & BOTTOM neighbours
       
      return this.walls[0] == sqBour.walls[2] == false ? false : true;
    } else if ((this.x + 1 == sqBour.x && this.y == sqBour.y) ||
               (this.x - 1 == sqBour.x && this.y == sqBour.y)){  // RIGHT & LEFT neighbours
              
      return this.walls[1] == sqBour.walls[3] == false ? false : true;
    }
    */
    return true;
  }
  
  @Override
  public int getCellWidth(){
    return this._cellWidth;
  }
  
  @Override
  public boolean equals(Object o){
    if (o instanceof AStarNode){
      AStarNode other = (AStarNode)o;
      return this.x == other.x && this.y == other.y;
    }
    return false;
  }
}