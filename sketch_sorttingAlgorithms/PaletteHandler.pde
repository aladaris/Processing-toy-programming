import java.lang.Math.*;

class PaletteHandler extends Handler implements I_Handler{
  
  public PaletteHandler(final int[] pixs){
    //println("n _elems = " + pixs.length); // DEBUG
    _elems = pixs;
    selectedIndex = 0;
  }
  
  public PaletteHandler(){
    this(new int[0]);
  }
  
  public void pixels(final int[] pixs){
    _elems = pixs;
  }
  
  public void show(){
  }
  
  // Returns true if the step can be done; false if not.  
  public boolean step(){
    return false;
  }
  public void run(){
    int [][] shades = new int[360][255];
    float mean = 0f;
    int usedHS = 0;  // Number of "h, s" pairs founded
    // Contamos las apariciones de píxeles segun su hue & saturation
    for (int i = 0; i < _elems.length; i++) {
      int h = (int)Math.max(0, Math.floor(hue(_elems[i])) - 1);
      //println(  Math.floor(hue(_elems[i])) - 1);  // DEBUG
      int s = (int)Math.max (0, Math.floor(saturation(_elems[i])) - 1);
      //println(h + ", " + s);  // DEBUG
      if (shades[h][s] <= 0)
        usedHS++;
      shades[h][s]++;
      mean++;
      //println("  " + shades[h][s]);  // DEBUG
    }
    /*
    // Calculamos la media de toda la matriz 'shades'
    for (int i = 0; i < 360; i++){
      for (int j = 0; j < 255; j++){
        //print("  " + shades[i][j]);  // DEBUG
        mean += shades[i][j];
      }
      //println("#");  // DEBUG
    }
    */
    //println("mean = " + mean);  // DEBUG
    mean /= usedHS;
    //println("mean / " + usedHS + " = " + mean);  // DEBUG
    
    // Paint it !
    pushMatrix();
    scale(3.151, 3.151);
    for (int i = 0; i < 360; i++){
      for (int j = 0; j < 255; j++){
          float hue = (float)i;
          float saturation = (float)j / 254;
          float lightness =  Math.min(0.5f, shades[i][j] / mean * 0.5);  // Only over the mean colors
          //float lightness =  Math.min(0.5f, shades[i][j]);  // All colors
          //println(hue + ", " + saturation+ ", " +lightness); // DEBUG
          fill(HSL2RGB(hue, saturation, lightness));
          rect(i, j, 1, 1);
      }
    }
    popMatrix();
    
  }
  
  private color HSL2RGB(float hue, float sat, float lum){
    float v;
    float red, green, blue;
    float m;
    float sv;
    int sextant;
    float fract, vsf, mid1, mid2;
 
    red = lum;   // default to gray
    green = lum;
    blue = lum;
    v = (lum <= 0.5) ? (lum * (1.0 + sat)) : (lum + sat - lum * sat);
    m = lum + lum - v;
    sv = (v - m) / v;
    hue /= 60.0;  //get into range 0..6
    sextant = (int)Math.floor(hue);  // int32 rounds up or down.
    fract = hue - sextant;
    vsf = v * sv * fract;
    mid1 = m + vsf;
    mid2 = v - vsf;
 
    if (v > 0)
    {
        switch (sextant)
        {
            case 0: red = v; green = mid1; blue = m; break;
            case 1: red = mid2; green = v; blue = m; break;
            case 2: red = m; green = v; blue = mid1; break;
            case 3: red = m; green = mid2; blue = v; break;
            case 4: red = mid1; green = m; blue = v; break;
            case 5: red = v; green = m; blue = mid2; break;
        }
    }
    //println( red * 255 + ", " + green * 255 + ", " + blue * 255);  // DEBUG
    return color((int)(red * 255), (int)(green * 255), (int)(blue * 255));
  }


};
