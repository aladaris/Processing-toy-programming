interface I_Handler{
  public void show();
  // Returns true if the step can be done; false if not.  
  public boolean step();
  public void run();
};
