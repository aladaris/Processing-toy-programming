PVector TARGET;
Popullation p;
int generation;

// Obstacles
PVector OBSTACLE_1_POS;
final float OBSTACLE_1_SIZE = 200f;

void setup(){
  size(1400, 900);
  background(0);
  
  TARGET = new PVector(width / 2, height / 4);
  p = new Popullation(POPULLATION_SIZE, TARGET);
  generation = 0;
  
  OBSTACLE_1_POS = new PVector(width / 2, height / 2);
}

void draw(){
  //background(0, 127);
 //<>//
  p.run();
  if (p.hasFinished()){
    p.evaluate();
    p.createNextGeneration();
    // DEBUG
    //Rocket[] parents = p.parentSelection(); //<>//
    //for (Rocket parent : parents){
    //  println("Parent fitness = ", parent.fitness);  // DEBUG
    //}
    // DEBUG
    
    //p = new Popullation(100, TARGET);
    generation++;
    background(0, 127);
  }
  
  
  
  // Obstacles
  noStroke();
  fill(0);
  ellipse(OBSTACLE_1_POS.x, OBSTACLE_1_POS.y, OBSTACLE_1_SIZE*2, OBSTACLE_1_SIZE*2);  // TODO: Why *2 ??
  
  fill(150, 10, 50);
  ellipse(TARGET.x, TARGET.y, 20, 20);
  
  //textSize(18);
  //text(String.format("STEP : %d", p.getCurrentStep() + 1), 5, height - 25);
  //text(String.format("GENERATION : %d", generation), 5, height - 5);
  
  // FPS in title bar
  final String txt_fps = String.format(getClass().getName()+ " STEP: %d  :: Generation: %d   [fps %6.2f]", p.getCurrentStep() + 1, generation + 1, frameRate);
  surface.setTitle(txt_fps);
}