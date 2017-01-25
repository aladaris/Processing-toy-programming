interface I_element{
  
  public void paint();
  public int value();
  public void value (int i_v);
  public Point2D position();

};

class Sqr implements I_element{
  
  public Sqr(final int i_x, final int i_y, final int i_v){
    this(i_x, i_y, i_v, 20);
  }
  
  public Sqr(final int i_x, final int i_y, final int i_v, final int i_s){
    position = new Point2D(i_x, i_y);
    value = i_v;
    size = i_s;
  }
  
  public void paint(){
    pushMatrix();
    translate(position.x, position.y);
    fill(color(value));
    rect(0, 0, size, size);
    popMatrix();
  }
  
  public int value() { return value; }
  public void value (int i_v) { value = i_v; }
  public Point2D position() { return position; }
  
  int value;
  Point2D position;
  int size;
};
