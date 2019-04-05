import java.util.List;
import java.util.ArrayList;

class ShapeDrawingTool {
    private List<PVector> _vtx = new ArrayList<PVector>();
    private float _vertexRadius = 5f;
    private int _vertexColor = 255;
    private int _lineColor = 255;
    
    public void draw(){
        ellipseMode(RADIUS);
        fill(_vertexColor);
        stroke(_lineColor);
        //for (PVector v : _vtx){
        if (!_vtx.isEmpty()){
            PVector v0;
            PVector v1;
            for (int i = 1; i < _vtx.size() + 1; i++){
                v0 = _vtx.get(i-1);
                ellipse(v0.x, v0.y, _vertexRadius, _vertexRadius);
                if (i < _vtx.size()){
                    v1 = _vtx.get(i);
                    line(v0.x, v0.y, v1.x, v1.y);
                }
            }
            v0 = _vtx.get(0);
            v1 = _vtx.get(_vtx.size() - 1);
            line(v0.x, v0.y, v1.x, v1.y);
        }
    }
    
    public PShape mouseHandler(ModeHandler.MODE mode){
        if (mode == ModeHandler.MODE.DRAW_OBSTACLES){
            switch(mouseButton){
              case LEFT:
                  _vtx.add(new PVector(mouseX, mouseY));
                  System.out.println("New vertex");  // DEBUG
                  break;
              
              case RIGHT:
                  if (!_vtx.isEmpty()){
                      _vtx.remove(_vtx.size() - 1);
                      System.out.println("Last vertex removed");  // DEBUG
                  }
                  break;
              case CENTER:
                  if (_vtx.size() >= 3){  // At least 3 vertex are required
                      System.out.println("New OBSTACLE");  // DEBUG
                      //pushMatrix();
                      PShape shape = createShape();
                      shape.beginShape();
                      shape.noStroke();
                      shape.fill(200,0,200, 100);
                      for (PVector v : _vtx){
                        shape.vertex(v.x, v.y);
                      }
                      shape.endShape();
                      _vtx.clear();
                      return shape;
                  }
                  break;
              default: break;
            }
          }
          return null;
    }
}