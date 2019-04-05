import com.thomasdiewald.pixelflow.java.DwPixelFlow;
import com.thomasdiewald.pixelflow.java.fluid.DwFluid2D;

import processing.core.*;
import processing.opengl.PGraphics2D;

final int BACKGROUND_COLOR = 0;
final int viewport_w = 1280;
final int viewport_h = 720;
final int viewport_x = 230;
final int viewport_y = 0;
final int fluidgrid_scale = 1;

public DwFluid2D fluid;  // fluid simulation
PGraphics2D pg_fluid;  // render targets
PGraphics2D pg_obstacles;  //texture-buffer, for adding obstacles
MousePressFuildData cb_fluid_data = new MousePressFuildData();  // interface for adding data to the fluid simulation

ShapeDrawingTool shapeDraw = new ShapeDrawingTool();
List<PShape> drawnObstacles = new ArrayList<PShape>();

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
    fluid.param.dissipation_velocity    = 0.92f;
    fluid.param.dissipation_temperature = 0.70f;
    fluid.param.vorticity               = 0.18f;
    fluid.addCallback_FluiData(cb_fluid_data);
    // pgraphics for fluid
    pg_fluid = (PGraphics2D) createGraphics(viewport_w, viewport_h, P2D);
    pg_fluid.smooth(4);
    // pgraphics for obstacles
    pg_obstacles = (PGraphics2D) createGraphics(viewport_w, viewport_h, P2D);
    
    ModeHandler.config(cb_fluid_data);

    frameRate(60);
    
    GUI.setupGUI(this, fluid, cb_fluid_data, 200, new PVector(20, 20));
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
    
    // Obstacle drawing
    shapeDraw.draw();
    
    // info
    String txt_fps = String.format(getClass().getName()+ "   [size %d/%d]   [frame %d]   [fps %6.2f]  [mode %s]", fluid.fluid_w, fluid.fluid_h, fluid.simulation_step, frameRate, ModeHandler.currentMode);
    surface.setTitle(txt_fps);
}

PShape drawingShape = null;
void drawObstacles(){
  if (ModeHandler.currentMode == ModeHandler.MODE.DRAW_OBSTACLES){
    if (drawingShape == null){
        drawingShape = createShape();
        drawingShape.beginShape();
        drawingShape.stroke(255);
        drawingShape.fill(127);
    }
  }
}

public void updateObstacles() {
  pg_obstacles.noSmooth();
  pg_obstacles.beginDraw();
  pg_obstacles.clear();
  for (PShape obs : drawnObstacles){
    pg_obstacles.shape(obs);
    //shape(obs);
  }
  pg_obstacles.endDraw();
  
  // add to the fluid-solver
    fluid.addObstacles(pg_obstacles);
}

void mouseClicked() {
  PShape newObstacle = shapeDraw.mouseHandler(ModeHandler.currentMode);
  if (newObstacle != null){
    drawnObstacles.add(newObstacle);
  }
}

void keyPressed() {
    if (key == 'M' || key == 'm'){
        ModeHandler.toggleMode();
    }
}