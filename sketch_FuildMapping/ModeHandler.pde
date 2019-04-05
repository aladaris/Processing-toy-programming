static class ModeHandler {
    public static enum MODE {ADD_FLUID, DRAW_OBSTACLES};
    private static MousePressFuildData _fuildData;
  
    public static MODE currentMode = MODE.DRAW_OBSTACLES;
    
    public static void config(final MousePressFuildData fData){
      _fuildData = fData;
    }
    
    public static void setMode(MODE newMode){
      currentMode = newMode;
      switch(newMode){
        case ADD_FLUID: _fuildData.Active = true; break;
        case DRAW_OBSTACLES: _fuildData.Active = false; break;
      }
    }
    
    public static void toggleMode(){
      if (currentMode == MODE.ADD_FLUID){
        setMode(MODE.DRAW_OBSTACLES);
      } else if (currentMode == MODE.DRAW_OBSTACLES){
        setMode(MODE.ADD_FLUID);
      }
    }
  
}