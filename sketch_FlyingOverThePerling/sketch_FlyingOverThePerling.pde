final int  SCALE = 20;
final int WIDTH = 8000;
final int HEIGHT = 6000;
final int COLS = WIDTH / SCALE;
final int ROWS = HEIGHT / SCALE;
final float ZMIN = -150f;
final float ZMAX = 150f;

float[][] heightPoints = new float[COLS][ROWS];


void setup(){
  size(1200, 800, P3D);
  //stroke(255);
  noFill();
}

float flying = 0f;
void draw(){
  background(0);
  
  updateHeightPoints(flying);
  flying -= 0.15f;
  
  translate(width/2, height/2+50);
  rotateX(PI/(3));
  translate(-WIDTH/2, -HEIGHT/2); 
  for (int y = 0; y < ROWS - 1; y++){
    beginShape();
    for (int x = 0; x < COLS; x++){
      stroke(map(heightPoints[x][y], ZMIN, ZMAX, 0, 255));
      vertex(x * SCALE, y * SCALE, heightPoints[x][y]);
      vertex(x * SCALE, (y+1) * SCALE, heightPoints[x][y+1]);
    }
    endShape();
  }
}

void updateHeightPoints(final float offset){
  float xOffset;
  float yOffset = offset;
  for (int y = 0; y < ROWS; y++){
    xOffset = 0f;
    for (int x = 0; x < COLS; x++){
      heightPoints[x][y] = map(noise(xOffset, yOffset), 0, 1, ZMIN, ZMAX);
      xOffset += 0.1f;
    }
    yOffset += 0.1f;
  }
}