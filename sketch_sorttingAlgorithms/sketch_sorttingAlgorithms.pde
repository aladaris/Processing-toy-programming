final int rows = 60;
final int cols = 60;
final int size = rows * cols;

// SELECT A SORTING ALGORITHM
//BubleHandler h = new BubleHandler(size);
QuickHandler h = new QuickHandler(size);

void setup(){
  size(1000, 900); 
  background(0);
  frameRate(600);
 

  noStroke();
  rectMode(CENTER);
  textSize(10);

}

void draw(){
  
  // DRAW SORTING ALGORITHM
  translate(25, 10);
  h.show(rows, cols);
  if (!h.step()){
    println("Fin");
    noLoop();
  }
  //saveFrame("C:\\Temp\\Quicksort\\frame-#########.png");


  // SORT IMAGE PIXELS BY HUE AND SATURATION
  /*
  runPaletteSingleImage("test2.png"); // Available images: test1.png, test2.png, test3.jpg, test4.jpg, test5.jpg
  */
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
  
  image(img, width - 155, 5, 150, 150);
  
  noLoop();
}