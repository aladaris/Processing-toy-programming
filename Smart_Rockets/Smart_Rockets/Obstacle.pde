enum OBSTACLE_TYPE {
  CIRCLE,
  POLY
};

class Obstacle{
  PVector pos;
  float radius;
  float[][] polyPoints;
  OBSTACLE_TYPE type;
  
  public Obstacle(float x, float y, float r){
    this.pos = new PVector(x, y);
    this.radius = r;
    this.type = OBSTACLE_TYPE.CIRCLE;
  }
  
  public Obstacle(float x, float y, float[][] polyPoints){
    this.pos = new PVector(x, y);
    this.polyPoints = polyPoints;
    this.type = OBSTACLE_TYPE.POLY;
  }
  
  public void draw() {
    fill(0, 50);
    switch(type){
      case CIRCLE:
        ellipse(pos.x, pos.y, radius * 2, radius * 2);
        break;
      case POLY:
      // TODO
        break;
    }
  }
  
  public boolean isInside(PVector point){
    switch(type){
      case CIRCLE:
        return dist(point.x, point.y, pos.x, pos.y) < radius;
      case POLY:
        return isInsidePolygon(point);
    }
    return false;
  }
  
  private boolean isInsidePolygon(PVector point){
    // https://stackoverflow.com/questions/22521982/check-if-point-is-inside-a-polygon
    
    // ray-casting algorithm based on
    // https://wrf.ecse.rpi.edu/Research/Short_Notes/pnpoly.html/pnpoly.html
    
    boolean inside = false;
    for (int i = 0, j = polyPoints.length - 1; i < polyPoints.length; j = i++) {
        float xi = polyPoints[i][0];
        float yi = polyPoints[i][1];
        float xj = polyPoints[j][0];
        float yj = polyPoints[j][1];
        
        boolean intersect = ((yi > point.y) != (yj > point.y)) && (point.x < (xj - xi) * (point.y - yi) / (yj - yi) + xi);
        if (intersect) inside = !inside;
    }
    return inside;
  }
  
}
