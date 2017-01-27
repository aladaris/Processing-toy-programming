import java.util.*;

enum NEIGHBOUR_POSITION {TOP, TOP_RIGHT, BOTTOM_RIGHT, BOTTOM, BOTTOM_LEFT, TOP_LEFT };

private static final Map<NEIGHBOUR_POSITION, PVector> NEIGHBOUR_MAP[];
static {
    NEIGHBOUR_MAP = new HashMap[2];
    // EVEN ROWS
    NEIGHBOUR_MAP[0] = new HashMap<NEIGHBOUR_POSITION, PVector>();
    NEIGHBOUR_MAP[0].put(NEIGHBOUR_POSITION.TOP,          new PVector(0,  -2));
    NEIGHBOUR_MAP[0].put(NEIGHBOUR_POSITION.TOP_RIGHT,    new PVector(0,  -1));
    NEIGHBOUR_MAP[0].put(NEIGHBOUR_POSITION.BOTTOM_RIGHT, new PVector(0,   1));
    NEIGHBOUR_MAP[0].put(NEIGHBOUR_POSITION.BOTTOM,       new PVector(0,   2));
    NEIGHBOUR_MAP[0].put(NEIGHBOUR_POSITION.BOTTOM_LEFT,  new PVector(-1,  1));
    NEIGHBOUR_MAP[0].put(NEIGHBOUR_POSITION.TOP_LEFT,     new PVector(-1, -1));
    // ODD ROWS
    NEIGHBOUR_MAP[1] = new HashMap<NEIGHBOUR_POSITION, PVector>();
    NEIGHBOUR_MAP[1].put(NEIGHBOUR_POSITION.TOP,          new PVector(0,  -2));
    NEIGHBOUR_MAP[1].put(NEIGHBOUR_POSITION.TOP_RIGHT,    new PVector(1,  -1));
    NEIGHBOUR_MAP[1].put(NEIGHBOUR_POSITION.BOTTOM_RIGHT, new PVector(1,   1));
    NEIGHBOUR_MAP[1].put(NEIGHBOUR_POSITION.BOTTOM,       new PVector(0,   2));
    NEIGHBOUR_MAP[1].put(NEIGHBOUR_POSITION.BOTTOM_LEFT,  new PVector(0,   1));
    NEIGHBOUR_MAP[1].put(NEIGHBOUR_POSITION.TOP_LEFT,     new PVector(0,  -1));
}


class HexAStarNode extends AStarNode {
  

  
  
  public List<HexAStarNode> neighbours;
  public HexAStarNode cameFrom;
  
  public HexAStarNode(final int xi, final int yi, final int cellWidth){
    super(xi, yi, cellWidth*2);
    
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
      Map<NEIGHBOUR_POSITION, PVector> neighbourMap;
      if (this.y % 2 == 0){
        neighbourMap = NEIGHBOUR_MAP[0];
      } else {
        neighbourMap = NEIGHBOUR_MAP[1];
      }
      
      for (PVector nbourPos : neighbourMap.values()){
        HexAStarNode node = board.getCell(this.x + (int)nbourPos.x, this.y + (int)nbourPos.y);
        if (node != null){
          neighbours.add(node);  // TOP
        }
      }
    }
  }
  
  @Override
  public void show(){
    final int w = _cellWidth;
    final color strokeColor = color(255, 255, 255);

    noStroke();
    fill(cellColor);
    ellipse(0, 0, _cellWidth, _cellWidth);  // CENTER
    strokeWeight(1);
    //beginShape();
    stroke(strokeColor);
    
     if (!walls[0]){
       line(- (w/2), -w, w/2, -w);
     }
     if (!walls[1]){
       line(w/2, -w, w/2, -w);
     }
     if (!walls[2]){
       line(w, 0, w/2, w);
     }
     if (!walls[3]){
       line(w/2, w, -(w/2), w);
     }
     if (!walls[4]){
       line(-(w/2), w, -w, 0);
     }
     if (!walls[5]){
       line(-w, 0, -(w/2),  -w);
     }
    
    /*
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
    */
  }
  
  @Override
  public void removeWalls(ICell neighbour){
    if (neighbour instanceof HexAStarNode){

      Map<NEIGHBOUR_POSITION, PVector> neighbourMap;
      if (this.y % 2 == 0){
        neighbourMap = NEIGHBOUR_MAP[0];
      } else {
        neighbourMap = NEIGHBOUR_MAP[1];
      }

      PVector nPos = neighbourMap.get(NEIGHBOUR_POSITION.TOP);
      if (this.x + nPos.x == neighbour.x && this.y + nPos.y == neighbour.y){  // TOP neighbour
        this.walls[0] = false;
        neighbour.walls[3] = false;
      }
      nPos = neighbourMap.get(NEIGHBOUR_POSITION.TOP_RIGHT);
      if (this.x + nPos.x == neighbour.x && this.y + nPos.y == neighbour.y){  // TR neighbour
        this.walls[1] = false;
        neighbour.walls[4] = false;
      }
      nPos = neighbourMap.get(NEIGHBOUR_POSITION.BOTTOM_RIGHT);
      if (this.x + nPos.x == neighbour.x && this.y + nPos.y == neighbour.y){// BR neighbour
        this.walls[2] = false;
        neighbour.walls[5] = false;
      }
      nPos = neighbourMap.get(NEIGHBOUR_POSITION.BOTTOM);
      if (this.x + nPos.x == neighbour.x && this.y + nPos.y == neighbour.y){  // BOTTOM neighbour
        this.walls[3] = false;
        neighbour.walls[0] = false;
      }
      nPos = neighbourMap.get(NEIGHBOUR_POSITION.BOTTOM_LEFT);
      if (this.x + nPos.x == neighbour.x && this.y + nPos.y == neighbour.y){// BL neighbour
        this.walls[4] = false;
        neighbour.walls[1] = false;
      }
      nPos = neighbourMap.get(NEIGHBOUR_POSITION.TOP_LEFT);
      if (this.x + nPos.x == neighbour.x && this.y + nPos.y == neighbour.y){// TL neighbour
        this.walls[5] = false;
        neighbour.walls[2] = false;
      }

    }
  }

  public boolean isWallBetweenCell(final HexAStarNode neighbour){
    
    Map<NEIGHBOUR_POSITION, PVector> neighbourMap;
    if (this.y % 2 == 0){
      neighbourMap = NEIGHBOUR_MAP[0];
    } else {
      neighbourMap = NEIGHBOUR_MAP[1];
    }

    PVector nPos = neighbourMap.get(NEIGHBOUR_POSITION.TOP);
    if (this.x + nPos.x == neighbour.x && this.y + nPos.y == neighbour.y){  // TOP neighbour        
      if ((this.walls[0] == false)&&(this.walls[0] == neighbour.walls[3])){
        return false;
      }
    } 
 
    nPos = neighbourMap.get(NEIGHBOUR_POSITION.TOP_RIGHT);
    if (this.x + nPos.x == neighbour.x && this.y + nPos.y == neighbour.y){// TR neighbour
      if ((this.walls[1] == false)&&(this.walls[1] == neighbour.walls[4])){
        return false;
      }
    } 
      
    nPos = neighbourMap.get(NEIGHBOUR_POSITION.BOTTOM_RIGHT);
    if (this.x + nPos.x == neighbour.x && this.y + nPos.y == neighbour.y){// BR neighbour
      if ((this.walls[2] == false)&&(this.walls[2] == neighbour.walls[5])){
        return false;
      }
    } 
      
    nPos = neighbourMap.get(NEIGHBOUR_POSITION.BOTTOM);
    if (this.x + nPos.x == neighbour.x && this.y + nPos.y == neighbour.y){// BOTTOM neighbour
      if ((this.walls[3] == false)&&(this.walls[3] == neighbour.walls[0])){
        return false;
      }
    } 
      
    nPos = neighbourMap.get(NEIGHBOUR_POSITION.BOTTOM_LEFT);
    if (this.x + nPos.x == neighbour.x && this.y + nPos.y == neighbour.y){// BL neighbour
      if ((this.walls[4] == false)&&(this.walls[4] == neighbour.walls[1])){
        return false;
      }
    } 
      
    nPos = neighbourMap.get(NEIGHBOUR_POSITION.TOP_LEFT);
    if (this.x + nPos.x == neighbour.x && this.y + nPos.y == neighbour.y){// TL neighbour
      if ((this.walls[5] == false)&&(this.walls[5] == neighbour.walls[2])){
        return false;
      }
    }
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