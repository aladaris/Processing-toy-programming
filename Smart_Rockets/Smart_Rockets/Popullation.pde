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
  
  public void evaluate(){
    float maxFit = -MAX_FLOAT;
    // Calculate fitness and get the highest value
    for (int i = 0; i < rockets.length; i++) {
      rockets[i].calculateFitness();
      //println("Fitness preNorm = ", i, rockets[i].fitness);  // DEBUG
      if (rockets[i].fitness > maxFit){
        maxFit = rockets[i].fitness;
      }
    }
    //println("Max fitness = ", maxFit);  // DEBUG
    // Normalize fitness values
    for (int i = 0; i < rockets.length; i++){
      rockets[i].fitness /= maxFit;
      println("Fitness = ", rockets[i].fitness);  // DEBUG
    }
  }
  
  public void createNextGeneration(){
    Rocket[] parents = parentSelection();
    java.util.List<Rocket> children = new ArrayList<Rocket>();
    for (int i = 0; i < parents.length; i++){
      DNA parentGenomeA;
      if (i > 0){
        parentGenomeA = parents[i-1].dna;
      } else {
        parentGenomeA = parents[parents.length - 1].dna;
      }
      DNA parentGenomeB = parents[i].dna;
      DNA childGenome   = parentGenomeA.crossover(parentGenomeB);
      childGenome.mutate();
      
      children.add(new Rocket(parents[i].target, childGenome));
    }
    rockets = children.toArray(new Rocket[children.size()]);
  }
  
  private Rocket[] parentSelection(){
    java.util.List<Rocket> parents = new ArrayList<Rocket>();
    int parentsCount = 0;
    int candidatePos;

    while (parentsCount < rockets.length) {
      candidatePos = (int)(random(1f) * rockets.length);
      if (random(1f) < rockets[candidatePos].fitness) {
        parents.add(rockets[candidatePos]);
        parentsCount++;
      }
    }
    
    return parents.toArray(new Rocket[parents.size()]);
  }

}