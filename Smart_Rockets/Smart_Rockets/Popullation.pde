class Popullation{
  private Rocket[] rockets;
  
  public Popullation(final int popullation_size, final PVector target_position){
    rockets = new Rocket[popullation_size];
    for (int i = 0; i < rockets.length; i++){
      rockets[i] = new Rocket(target_position);
    }
  }
  
  public void run(){
    for (int i = 0; i < rockets.length; i++){
      rockets[i].update();
      rockets[i].show();
    }
  }
  
  public int getCurrentStep(){
    if (rockets.length > 0){
      return rockets[0].getCurrentDNAStep();
    }
    return -1;
  }
  
  public boolean hasFinished(){
    return getCurrentStep() + 1 == STEPS_PER_GENERATION;
  }
  
}