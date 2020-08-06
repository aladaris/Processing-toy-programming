import java.util.List;
import java.util.ArrayList;

import spout.*;

Spout spout;

PVector TARGET;
Popullation p;
int generation;

// Obstacles
PVector OBSTACLE_1_POS;
final float OBSTACLE_1_SIZE = 200f;
List<Obstacle> obstacles;

processing.core.PApplet APPLET = this;

void setup(){
  randomSeed(3);
  size(1920, 1080, P3D);
  smooth(16);
  frameRate(30);
  background(0);
  
  TARGET = new PVector(width / 2, -25);
  p = new Popullation(GLOBALS.POPULLATION_SIZE, TARGET);
  generation = 0;
  
  //OBSTACLE_1_POS = new PVector(width / 2, height / 2);
  
  obstacles = new ArrayList<Obstacle>();
  /*
  obstacles.add(new Obstacle(width / 3.5, height / 3, 200f));
  obstacles.add(new Obstacle(width / 1.70, height / 2.3, 85f));
  obstacles.add(new Obstacle(width / 1.93, height / 3.3, 30f));
  obstacles.add(new Obstacle(width / 1.55, height / 4.22, 90f));
  */
  
  //obstacles.add(new Obstacle(width/2, height/2 + 150, 200f));
  
  obstacles.add(new Obstacle(width/2, height/2, new float[][]{{600, 500},{width/2, 950},{width-600, 500}})); // Point down -- V
  //obstacles.add(new Obstacle(width/2, height/2, new float[][]{{600, height-250},{width/2, height/4},{width-600, height-250}}));

  
  //GUI.setupGUI(this, 200, new PVector(20, 20));
  
  spout = new Spout(this);
  spout.createSender("smart Rockets", 1920, 1080);
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
      //background(0, 127);
      
      fill(0, 3);
      rect(width/2,height/2,width,height);
      
      GLOBALS.GEN_R += 13.66;
      GLOBALS.GEN_G += 4.33;
      GLOBALS.GEN_B -= 7.5;
    }
    
    
    
    // Obstacles
    //noStroke();
    //stroke(20);
    
    /*
    for (Obstacle obs : obstacles){
      obs.draw();
    }
    */
    
    // Target
    //noStroke();
    //fill(150, 10, 50);
    //ellipse(TARGET.x, TARGET.y, 20, 20);
  }

  spout.sendTexture();

  // FPS in title bar
  final String txt_fps = String.format(getClass().getName()+ " STEP: %d  :: Generation: %d   [fps %6.2f]", p.getCurrentStep() + 1, generation + 1, frameRate);
  surface.setTitle(txt_fps);
}
