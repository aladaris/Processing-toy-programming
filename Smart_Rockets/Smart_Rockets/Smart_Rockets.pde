PVector TARGET;
Popullation p;
int generation;
void setup(){
  size(800, 800);
  
  TARGET = new PVector(width / 2, 50);
  p = new Popullation(120, TARGET);
  generation = 0;
}

void draw(){
  background(0);
 //<>//
  p.run();
  if (p.hasFinished()){
    p = new Popullation(120, TARGET);  // TODO: All the genetic stuff
    generation++;
  }
  
  fill(150, 10, 50);
  ellipse(TARGET.x, TARGET.y, 20, 20);
  text(String.format("STEP: %d", p.getCurrentStep() + 1), 5, height - 20);
  text(String.format("GEN : %d", generation), 5, height - 5);
  
  // FPS in title bar
  final String txt_fps = String.format(getClass().getName()+ "   [fps %6.2f]", frameRate);
  surface.setTitle(txt_fps);
}