import com.thomasdiewald.pixelflow.java.fluid.DwFluid2D;

class MousePressFuildData implements DwFluid2D.FluidData{
  public boolean Active = false;
  
  public float red = 0.85f;
  public float green = 0.05f;
  public float blue = 0.70f;
  public float intensity = 1.0f;
  public float radius = 40f;
  
  // update() is called during the fluid-simulation update step.
  @Override
  public void update(DwFluid2D fluid) {
  
    float px, py, vx, vy, vscale, temperature;
    
    if(mousePressed && Active && !GUI.isMouseOver()){

      vscale = 15;
      px     = mouseX;
      py     = height-mouseY;
      vx     = (mouseX - pmouseX) * +vscale;
      vy     = (mouseY - pmouseY) * -vscale;
      temperature = 5f;
      
      fluid.addVelocity   (px, py, radius, vx, vy);
      
      if(mouseButton == LEFT){
        fluid.addTemperature(px, py, radius, temperature);
        //fluid.addDensity    (px, py, radius, 0,0,0,intensity);
        fluid.addDensity    (px, py, radius, red, green, blue, intensity);
      }
    }

  }
}