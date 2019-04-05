import com.thomasdiewald.pixelflow.java.fluid.DwFluid2D;

class MyFluidData implements DwFluid2D.FluidData{
  
  // update() is called during the fluid-simulation update step.
  @Override
  public void update(DwFluid2D fluid) {
  
    float px, py, vx, vy, radius, vscale, intensity, temperature;
    
    if(mousePressed){

      vscale = 15;
      px     = mouseX;
      py     = height-mouseY;
      vx     = (mouseX - pmouseX) * +vscale;
      vy     = (mouseY - pmouseY) * -vscale;
      radius = 20;
      intensity = 1.0f;
      temperature = 5f;
      
      fluid.addVelocity   (px, py, radius, vx, vy);
      
      if(mouseButton == LEFT){
        fluid.addTemperature(px, py, radius, temperature);
       
        radius = 40;
        fluid.addDensity    (px, py, radius, 0,0,0,intensity);
        radius = 36;
        fluid.addDensity    (px, py, radius, 0,0.4f,1,intensity);
      }
    }

  }
}