import controlP5.Accordion;
import controlP5.ControlP5;
import controlP5.Group;
import controlP5.RadioButton;
import controlP5.Toggle;

static class GUI {
  static ControlP5 _cp5;
  
  static public void setupGUI(processing.core.PApplet applet,
                              DwFluid2D fluid, MousePressFuildData fluidData,
                              int guiWidth, final PVector guiPosition){
    
    _cp5 = new ControlP5(applet);
    
    int sx, sy, px, py, oy;
    
    sx = 100;
    sy = 14;
    oy = (int)(sy*1.5f);
    

    ////////////////////////////////////////////////////////////////////////////
    // GUI - FLUID
    ////////////////////////////////////////////////////////////////////////////
    Group group_fluid = _cp5.addGroup("fluid");
    {
      group_fluid.setHeight(20).setSize(guiWidth, 300)
      .setBackgroundColor(1000).setColorBackground(180);
      group_fluid.getCaptionLabel().align(CENTER, CENTER);
      
      px = 10; py = 15;
      
      _cp5.addButton("reset").setGroup(group_fluid)
          .plugTo(applet, "fluid_reset").setSize(80, 18).setPosition(px, py);
     
      _cp5.addSlider("velocity").setGroup(group_fluid).setSize(sx, sy).setPosition(px, py+=(int)(oy*1.5f))
          .setRange(0, 1).setValue(fluid.param.dissipation_velocity).plugTo(fluid.param, "dissipation_velocity");
      
      _cp5.addSlider("density").setGroup(group_fluid).setSize(sx, sy).setPosition(px, py+=oy)
          .setRange(0, 1).setValue(fluid.param.dissipation_density).plugTo(fluid.param, "dissipation_density");
      
      _cp5.addSlider("temperature").setGroup(group_fluid).setSize(sx, sy).setPosition(px, py+=oy)
          .setRange(0, 1).setValue(fluid.param.dissipation_temperature).plugTo(fluid.param, "dissipation_temperature");
      
      _cp5.addSlider("vorticity").setGroup(group_fluid).setSize(sx, sy).setPosition(px, py+=oy)
          .setRange(0, 1).setValue(fluid.param.vorticity).plugTo(fluid.param, "vorticity");
          
      _cp5.addSlider("iterations").setGroup(group_fluid).setSize(sx, sy).setPosition(px, py+=oy)
          .setRange(0, 80).setValue(fluid.param.num_jacobi_projection).plugTo(fluid.param, "num_jacobi_projection");
            
      _cp5.addSlider("timestep").setGroup(group_fluid).setSize(sx, sy).setPosition(px, py+=oy)
          .setRange(0, 1).setValue(fluid.param.timestep).plugTo(fluid.param, "timestep");
          
      _cp5.addSlider("gridscale").setGroup(group_fluid).setSize(sx, sy).setPosition(px, py+=oy)
          .setRange(0, 50).setValue(fluid.param.gridscale).plugTo(fluid.param, "gridscale");
    }
    
    Group group_fluidData = _cp5.addGroup("fluidData");
    {
      group_fluidData.setHeight(20).setSize(guiWidth, 300)
        .setBackgroundColor(1000).setColorBackground(180);
      group_fluidData.getCaptionLabel().align(CENTER, CENTER);
      
      px = 10; py = 15;
      _cp5.addSlider("Radius").setGroup(group_fluidData).setSize(sx, sy).setPosition(px, py+=oy)
          .setRange(0, 150).setValue(fluidData.radius).plugTo(fluidData, "radius");
      _cp5.addSlider("RED").setGroup(group_fluidData).setSize(sx, sy).setPosition(px, py+=oy)
          .setRange(0, 1.0f).setValue(fluidData.red).plugTo(fluidData, "red");
      _cp5.addSlider("GREEN").setGroup(group_fluidData).setSize(sx, sy).setPosition(px, py+=oy)
          .setRange(0, 1.0f).setValue(fluidData.green).plugTo(fluidData, "green");
      _cp5.addSlider("BLUE").setGroup(group_fluidData).setSize(sx, sy).setPosition(px, py+=oy)
          .setRange(0, 1.0f).setValue(fluidData.blue).plugTo(fluidData, "blue");
      _cp5.addSlider("Intensity").setGroup(group_fluidData).setSize(sx, sy).setPosition(px, py+=oy)
          .setRange(0, 1.0f).setValue(fluidData.intensity).plugTo(fluidData, "intensity");
    }
    
    ////////////////////////////////////////////////////////////////////////////
    // GUI - ACCORDION
    ////////////////////////////////////////////////////////////////////////////
    _cp5.addAccordion("acc").setPosition(guiPosition.x, guiPosition.y).setWidth(guiWidth).setSize(guiWidth, applet.height)
      .setCollapseMode(Accordion.MULTI)
        .addItem(group_fluid)
        .addItem(group_fluidData)
      .open(1);
  }
  
  static boolean isMouseOver(){
    return _cp5.isMouseOver();
  }
  
}