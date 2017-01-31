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
  
}