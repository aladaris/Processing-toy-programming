class Cross {
  private PVector _pos;
  private float _s;
  private byte _stroke = 0;
  private float _halfSide;
  private float _oneAndHalfSide;
  
  public PShape shape;
  public float angle = 0f;
  public int colour = 0x000000;
  
  public Cross(float x, float y, float side){
    _pos = new PVector(x, y);
    _s = side;
    _halfSide = _s / 2f;
    _oneAndHalfSide = _s + _halfSide;
    shape = createShape();

    shape.beginShape();
    shape.stroke(_stroke);
    shape.fill(colour);

    shape.vertex(-_oneAndHalfSide, _halfSide);
    shape.vertex(-_oneAndHalfSide, -_halfSide);
    shape.vertex(-_halfSide, -_halfSide);
    shape.vertex(-_halfSide, -_oneAndHalfSide);
    shape.vertex(_halfSide, -_oneAndHalfSide);
    shape.vertex(_halfSide, -_halfSide);
    shape.vertex(_oneAndHalfSide, -_halfSide);
    shape.vertex(_oneAndHalfSide, _halfSide);
    shape.vertex(_halfSide, _halfSide);
    shape.vertex(_halfSide, _oneAndHalfSide);
    shape.vertex(-_halfSide, _oneAndHalfSide);
    shape.vertex(-_halfSide, _halfSide);
    shape.vertex(-_oneAndHalfSide, _halfSide);

    shape.endShape();
  }
  
  public PVector getPosition() { return _pos; }
  
  public void move(PVector vector){
    _pos = vector;
  }
  
  public void draw(){
    pushMatrix();
    translate(_pos.x , _pos.y);
    rotate(radians(angle));
    shape(shape, 0, 0);    
    popMatrix();
  }
}