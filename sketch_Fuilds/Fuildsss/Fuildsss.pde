import com.thomasdiewald.pixelflow.java.DwPixelFlow;
import com.thomasdiewald.pixelflow.java.fluid.DwFluid2D;

import processing.core.*;
import processing.opengl.PGraphics2D;
  
int viewport_w = 1280;
int viewport_h = 720;
int viewport_x = 230;
int viewport_y = 0;
  
  
//  int viewport_w = 800;
//  int viewport_h = 800;
  int fluidgrid_scale = 1;
  
  int BACKGROUND_COLOR = 255;
  
  // fluid simulation
  public DwFluid2D fluid;
  
  // render targets
  PGraphics2D pg_fluid;
  
  //texture-buffer, for adding obstacles
  PGraphics2D pg_obstacles;

  public void settings() {
    size(viewport_w, viewport_h, P2D);
    smooth(2);
  }
  
  
  public void setup() {
    
    surface.setLocation(viewport_x, viewport_y);
       
    // main library context
    DwPixelFlow context = new DwPixelFlow(this);
    context.print();
    context.printGL();
    
    // fluid simulation
    fluid = new DwFluid2D(context, viewport_w, viewport_h, fluidgrid_scale);

    // set some simulation parameters
    fluid.param.dissipation_density     = 0.98f;
    fluid.param.dissipation_velocity    = 0.72f;
    fluid.param.dissipation_temperature = 0.99f;
    fluid.param.vorticity               = 0.10f;
    
    // interface for adding data to the fluid simulation
    MyFluidData cb_fluid_data = new MyFluidData();
    fluid.addCallback_FluiData(cb_fluid_data);
   
    // pgraphics for fluid
    pg_fluid = (PGraphics2D) createGraphics(viewport_w, viewport_h, P2D);
    pg_fluid.smooth(4);
    
    // pgraphics for obstacles
    pg_obstacles = (PGraphics2D) createGraphics(viewport_w, viewport_h, P2D);

    frameRate(60);
  }
  
  final int CROSS_COUNT = 800;
  Cross[] crosses = new Cross[CROSS_COUNT];
  public void updateObstacles() {
    pg_obstacles.noSmooth();
    pg_obstacles.beginDraw();
    pg_obstacles.clear();
    //pg_obstacles.rectMode(CENTER);
    //pg_obstacles.noStroke();
    //pg_obstacles.fill(64);
    // obstacles   
    //randomSeed(millis());
    for(int i = 0; i < CROSS_COUNT; i++){
      //float px = random(width);
      //float py = random(height);
      //float sx = random(15, 60);
      //float sy = random(15, 60);
      //pg_obstacles.rect(px, py, sx, sy);
      if (crosses[i] == null){
        crosses[i] = new Cross(random(width), random(height), 7f);
        crosses[i].shape.rotate(random(0.01, 5));
      }
      crosses[i].shape.rotate(0.05f);
      pg_obstacles.shape(crosses[i].shape, crosses[i].getPosition().x, crosses[i].getPosition().y);
    }
    /*
    // border-obstacle
    pg_obstacles.rectMode(CORNER);
    pg_obstacles.strokeWeight(20);
    pg_obstacles.stroke(64);
    pg_obstacles.noFill();
    pg_obstacles.rect(0, 0, pg_obstacles.width, pg_obstacles.height);
    */
    pg_obstacles.endDraw();
    
    // add to the fluid-solver
    fluid.addObstacles(pg_obstacles);
  }
  

  public void draw() {
    
    updateObstacles();
    
    // update simulation
    fluid.update();
    
    // clear render target
    pg_fluid.beginDraw();
    pg_fluid.background(BACKGROUND_COLOR);
    pg_fluid.endDraw();

    // render fluid stuff
    fluid.renderFluidTextures(pg_fluid, 0);

    // display
    image(pg_fluid    , 0, 0);
    image(pg_obstacles, 0, 0);

    // info
    String txt_fps = String.format(getClass().getName()+ "   [size %d/%d]   [frame %d]   [fps %6.2f]", fluid.fluid_w, fluid.fluid_h, fluid.simulation_step, frameRate);
    surface.setTitle(txt_fps);
  }
  