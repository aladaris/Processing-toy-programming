final int size = 7500;
//BubleHandler b = new BubleHandler(size);
QuickHandler q = new QuickHandler(size);

//import processing.video.*;
//Capture cam;

void setup(){
  size(1000, 900); 
  background(0);
  frameRate(600);
 
 /*
  // Show cameras
  
  String[] cameras = Capture.list();
  for (int i = 0; i < cameras.length; i++)
    println("[" + i + "] " + cameras[i]);
  
  
  cam = new Capture(this, Capture.list()[3]);  // [61] name=Logitech QuickCam S7500,size=640x400,fps=30
  cam.start();
*/  

  noStroke();
  rectMode(CENTER);
  textSize(10);

}

void draw(){
  //runPaletteSingleImage("test5.jpg");
  
  
  
  /*
  if (cam.available()){
    cam.read();
    p.pixels(cam.foo);
    p.run();
  }
  */
  
  
  q.show(15, 500);
  if (!q.step()){
    println("Fin");
    noLoop();
  }
  //saveFrame("C:\\Temp\\Quicksort\\frame-#########.png");
  
}

void runPaletteSingleImage(String imgStr){
  PaletteHandler p = new PaletteHandler();
  PImage img = loadImage(imgStr);
  p.pixels(img.pixels);
  p.run();
    
  fill(255,255,255,128);
  int text_x = 10;
  text("S", text_x+1, 20);
  text("a", text_x, 30);
  text("t", text_x+1, 40);
  text("u", text_x, 50);
  text("r", text_x+1, 60);
  text("a", text_x, 70);
  text("t", text_x+1, 80);
  text("i", text_x+1, 90);
  text("o", text_x, 100);
  text("n", text_x, 110);
  text("▼", text_x-1, 125);
  text("HUE ►", text_x + 15, 10);
  
  noLoop();
}