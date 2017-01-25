import java.util.*;

class HexAStarNode extends AStarNode {
  
  public List<HexAStarNode> neighbours;
  public HexAStarNode cameFrom;
  
  public HexAStarNode(final int xi, final int yi, final int cellWidth, final boolean evenRow){
    super(xi, yi, cellWidth);
    
    cellColor = color(0, 0, 0);

    neighbours = new ArrayList<HexAStarNode>();
    cameFrom = null;
    _pos = new PVector(x * (2 * _cellWidth), y * (2 * _cellWidth));

    
    walls = new boolean[6];  // 0.Top, 1.TR, 2.BR, 3.Bottom, 4.BL, 5.TL
    for (int i = 0; i < walls.length; i++){
      walls[i] = true;
    }
    // Disable redundant borders
    //walls[0] = y == 0 ? true : false;  // TOP
    //walls[6] = x == 0 ? true : false;  // LEFT
  }
  
  public void addNeighbours(final HexBoard board){
    if (board != null){
      
      int x = this.x;
      int y = this.y - 1;
      HexAStarNode node = board.getCell(x, y);
      if (node != null){
        neighbours.add(node);  // TOP
      }
      
      x = this.x + 1;
      y = this.y;
      node = board.getCell(x, y);
      if (node != null){
        neighbours.add(node);  // TR
      }
      
      x = this.x + 1;
      y = this.y + 1;
      node = board.getCell(x, y);
      if (node != null){
        neighbours.add(node);  // BR
      }

      x = this.x;
      y = this.y + 1;
      node = board.getCell(x, y);
      if (node != null){
        neighbours.add(node);  // BOTTOM
      }
      
      x = this.x - 1;
      y = this.y + 1;
      node = board.getCell(x, y);
      if (node != null){
        neighbours.add(node);  // BL
      }
      
      x = this.x - 1;
      y = this.y;
      node = board.getCell(x, y);
      if (node != null){
        neighbours.add(node);  // TL
      }
    }
  }
  
  @Override
  public void show(){
    final int w = _cellWidth;
    final color strokeColor = color(255, 255, 255);

    stroke(strokeColor);
    strokeWeight(1);
    fill(cellColor);
    beginShape();
    if (!walls[0]){ noStroke(); }
    vertex(- (w/2), -w);
    vertex(w/2, -w);
    stroke(strokeColor);
    if (!walls[1]){ noStroke(); }
    vertex(w/2, -w);
    vertex(w, 0);
    stroke(strokeColor);
    if (!walls[2]){ noStroke(); }
    vertex(w, 0);
    vertex(w/2, w);
    stroke(strokeColor);
    if (!walls[3]){ noStroke(); }
    vertex(w/2, w);
    vertex(-(w/2), w);
    stroke(strokeColor);
    if (!walls[4]){ noStroke(); }
    vertex( -(w/2), w);
    vertex(-w, 0);
    stroke(strokeColor);
    if (!walls[5]){ noStroke(); }
    vertex( -w, 0);
    vertex(-(w/2),  -w);
    endShape();
    
    fill(255);
    ellipse(0, 0, 0.5, 0.5);  // CENTER (DEBUG)
    
    /*
    if (walls[0])
      line(- (w/2), -w, w/2, -w);  // TOP
    if (walls[1])
      line(w/2, -w, w, 0);  // TR
    if (walls[2])
      line(w, 0, w/2, w);  // BR
    if (walls[3])
      line(w/2, w,  -(w/2), w);  // BOTTOM
    if (walls[4])
      line( -(w/2), w, -w, 0);  // BL
    if (walls[5])
      line( -w, 0,  -(w/2),  -w);  // TL
    */
  }
  
  @Override
  public void removeWalls(ICell neighbour){
    if (neighbour instanceof HexAStarNode){
      //HexAStarNode nbour = (HexAStarNode)neighbour;
      if (this.x == neighbour.x && this.y - 1 == neighbour.y){  // TOP neighbour
        this.walls[0] = false;
        neighbour.walls[3] = false;
      } else if (this.x + 1 == neighbour.x && this.y == neighbour.y){  // TR neighbour
        this.walls[1] = false;
        neighbour.walls[4] = false;
      } else if (this.x + 1 == neighbour.x && this.y + 1 == neighbour.y){  // BR neighbour
        this.walls[2] = false;
        neighbour.walls[5] = false;
      } else if (this.x == neighbour.x && this.y + 1 == neighbour.y){  // BOTTOM neighbour
        this.walls[3] = false;
        neighbour.walls[0] = false;
      } else if (this.x - 1 == neighbour.x && this.y + 1 == neighbour.y){  // BL neighbour
        this.walls[4] = false;
        neighbour.walls[1] = false;
      } else if (this.x - 1 == neighbour.x && this.y == neighbour.y){  // TL neighbour
        this.walls[5] = false;
        neighbour.walls[2] = false;
      }
    }
  }

  public boolean isWallBetweenCell(final HexAStarNode nbour){
    
      if (this.x == nbour.x && this.y - 1 == nbour.y){  // TOP neighbour        
        if ((this.walls[0] == false)&&(this.walls[0] == nbour.walls[3])){
          return false;
        }
      } else if (this.x + 1 == nbour.x && this.y == nbour.y){  // TR neighbour
        if ((this.walls[1] == false)&&(this.walls[1] == nbour.walls[4])){
          return false;
        }
      } else if (this.x + 1 == nbour.x && this.y + 1 == nbour.y){  // BR neighbour
        if ((this.walls[2] == false)&&(this.walls[2] == nbour.walls[5])){
          return false;
        }
      } else if (this.x == nbour.x && this.y + 1 == nbour.y){  // BOTTOM neighbour
        if ((this.walls[3] == false)&&(this.walls[3] == nbour.walls[0])){
          return false;
        }
      } else if (this.x - 1 == nbour.x && this.y + 1 == nbour.y){  // BL neighbour
        if ((this.walls[4] == false)&&(this.walls[4] == nbour.walls[1])){
          return false;
        }
      } else if (this.x - 1 == nbour.x && this.y == nbour.y){  // TL neighbour
        if ((this.walls[5] == false)&&(this.walls[5] == nbour.walls[2])){
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