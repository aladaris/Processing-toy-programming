import java.util.HashSet;

class DNA {
  private PVector[] genes;
  private int seqPos;  // Sequencing position
  
  public DNA(int genome_length){
    if (genome_length < 0){
      genome_length = 0;
    }
    genes = new PVector[genome_length];
    for (int i = 0; i < genes.length; i++){
      genes[i] = PVector.random2D();
      genes[i].setMag(FORCE_MAGNITUDE);
    }
    seqPos = 0;
  }
  
  public DNA (final PVector[] genes){
    this.genes = genes;
    this.seqPos = 0;
  }
  
  public boolean sequencingCanContinue(){
    return seqPos < genes.length;
  }
  
  public PVector getNextGene(){
    if (seqPos + 1 >= genes.length){
      return genes[seqPos];
    }
    return genes[seqPos++];
  }
  
  public int getCurrentStep(){
    return seqPos;
  }
  
  public void mutate(){
    for (int i = 0; i < this.genes.length; i++){
      if (random(1) < 0.001){
        this.genes[i] = PVector.random2D();
        this.genes[i].setMag(FORCE_MAGNITUDE);
        println("Mutating", i);  // DEBUG
      }
    }
  }
  
  public DNA crossover(final DNA d2){
    if (this.genes.length == d2.genes.length){
      PVector[] childGenes = new PVector[this.genes.length];
      for (int i = 0; i < childGenes.length; i++){
        childGenes[i] = random(1f) < 0.5f ? this.genes[i] : d2.genes[i];
      }
      /*
      int midPoint = (int)random(this.genes.length);
      for (int i = 0; i < childGenes.length; i++){
        if (i < midPoint){
          childGenes[i] = this.genes[i];
        } else {
          childGenes[i] = d2.genes[i];
        }
      }
      */
      return new DNA(childGenes);
    }
    return this;
  }

}