import java.util.List;
import java.util.ArrayList;

PVector TARGET;
Popullation p;
int generation;

// Obstacles
PVector OBSTACLE_1_POS;
final float OBSTACLE_1_SIZE = 200f;
List<Obstacle> obstacles;

void setup(){
  size(1000, 900);
  background(0);
  
  TARGET = new PVector(width / 2, height / 4);
  p = new Popullation(GLOBALS.POPULLATION_SIZE, TARGET);
  generation = 0;
  
  //OBSTACLE_1_POS = new PVector(width / 2, height / 2);
  
  obstacles = new ArrayList<Obstacle>();
  obstacles.add(new Obstacle(width / 3.5, height / 3, 200f));
  obstacles.add(new Obstacle(width / 1.70, height / 2.3, 85f));
  obstacles.add(new Obstacle(width / 1.93, height / 3.3, 30f));
  obstacles.add(new Obstacle(width / 1.55, height / 4.22, 90f));
  
  //GUI.setupGUI(this, 200, new PVector(20, 20));
}

void draw(){
  if (!GLOBALS.PAUSED){
    p.run();
    if (p.hasFinished()){
      p.evaluate();
      p.createNextGeneration();
      
      //save(String.format("C:\\Temp\\Gen_%s_mag%.3f_steps%d_popSize%d_mut%.2f_velLimit%.1f.png", generation, GLOBALS.FORCE_MAGNITUDE, GLOBALS.STEPS_PER_GENERATION, GLOBALS.POPULLATION_SIZE, GLOBALS.MUTATION_RATE, GLOBALS.VELOCITY_LIMIT));
   //<>//
      generation++;
      background(0, 127);
    }
    
    
    
    // Obstacles
    //noStroke();
    //stroke(20);
    
    //for (Obstacle obs : obstacles){
    Obstacle obs;
    for (int i = 0; i < obstacles.size(); i++){
      obs = obstacles.get(i);
      fill(0);
      ellipse(obs.pos.x, obs.pos.y, obs.radius * 2, obs.radius * 2);  // TODO: Why *2 ??
      fill(127);
      text(i, obs.pos.x, obs.pos.y);
    }
    
    // Target
    noStroke();
    fill(150, 10, 50);
    ellipse(TARGET.x, TARGET.y, 20, 20);
  }

  // FPS in title bar
  final String txt_fps = String.format(getClass().getName()+ " STEP: %d  :: Generation: %d   [fps %6.2f]", p.getCurrentStep() + 1, generation + 1, frameRate);
  surface.setTitle(txt_fps);
}