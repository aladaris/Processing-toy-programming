class Rocket{
  private PVector pos;  // Position coordinates
  private PVector vel;  // Velocity vector
  private PVector acc;  // Acceleration vector
  private PVector target;  // Target point coordinates
  private boolean completed;
  private boolean crashed;
  private DNA dna;
  private float fitness;
  private int completeStep;
  
  private final color ROCKET_COLOR = color(255, 100);
  private final int ROCKET_LENGTH = 35;
  private final int ROCKET_WIDTH = 10;
  private final float ROCKET_MIN_TARGET_DISTANCE = 10f;
  
  public Rocket(final PVector target_position, final DNA dna){
    this(target_position);
    this.dna = dna;
  }
  
  public Rocket(final PVector target_position){
    this.pos = new PVector(width / 2f, height - 10);
    this.vel = new PVector(0f, 0f);
    this.acc = new PVector(0f, 0f);
    this.target = target_position;
    this.completed = false;
    this.crashed = false;
    this.dna = new DNA(STEPS_PER_GENERATION);
    this.fitness = 0f;
    this.completeStep = -1;
  }
  
    
  public void applyForce(final PVector force){
    this.acc.add(force);
  }
  
  public int getCurrentDNAStep(){
    return dna.getCurrentStep();
  }
  
  public void update(){
    float d = dist(pos.x, pos.y, target.x, target.y);
    if (d < ROCKET_MIN_TARGET_DISTANCE){
      this.completed = true;
      this.pos = this.target;
      this.completeStep = getCurrentDNAStep();
    }
    
    if (this.pos.x > width || this.pos.x < 0) {
      this.crashed = true;
    }
    if (this.pos.y > height || this.pos.y < 0) {
      this.crashed = true;
    }
    
    // Obstacles
    if (dist(this.pos.x, this.pos.y, OBSTACLE_1_POS.x, OBSTACLE_1_POS.y) < OBSTACLE_1_SIZE){
      this.crashed = true;
    }
    
    this.applyForce(dna.getNextGene());
    if (!this.completed && !this.crashed) {
      this.vel.add(this.acc);
      this.pos.add(this.vel);
      this.acc.mult(0);
      this.vel.limit(4);
    }
    
  }
  
  public void show(){
    pushMatrix();
    noStroke();
    fill(ROCKET_COLOR);
    translate(this.pos.x, this.pos.y);
    rotate(this.vel.heading());
    rectMode(CENTER);
    rect(0, 0, ROCKET_LENGTH, ROCKET_WIDTH);
    popMatrix();
  }
  
  public void calculateFitness() {
    //println("dist(", this.pos.x, this.pos.y, target.x, target.y);  // DEBUG
    float d = dist(pos.x, pos.y, target.x, target.y);
    if (d != 0f) {
      this.fitness = 1f / d;
    } else {
      this.fitness = d;
    }
    //this.fitness = map(d, 0, width, width, 0);
    if (this.completed) {
      this.fitness *= ((1 / this.completeStep) * 30);
    }
    if (this.crashed) {
      this.fitness /= 10;
    }
  }
}