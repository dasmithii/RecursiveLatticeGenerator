// Represents a recursive lattice structure. It is generated
// by layering n-pronged structures within eachother (see the
// 'fractalize' method for more information.
class Lattice {
  private PGraphics buffer; /* so we don't have to draw on-screen */
  private int dimension;    /* prongs per iteration */
  private float precision;  /* base case of recursion */
  private float radius;     /* original prong length */
  private float angle;      /* ngle between prongs */
  private Painter painter;  /* color scheme */
  
  // Stores parameters, calculates some helper values, and
  // generates.
  Lattice(int d, float p, Painter c){
    painter = c;
    dimension = d;
    precision = p;
    radius = (width+height)/6.5;
    angle = 2*PI/d;
    generate();
  }
  
  // Create PGraphics buffer so drawing can be done without
  // displaying on screen. Recursively generate lattice in 
  // the center of this buffer.
  private void generate(){
    buffer = createGraphics(width*2, height*2);
    buffer.beginDraw();
    buffer.background(black);
    buffer.pushMatrix();
    buffer.translate(buffer.width/2, buffer.height/2);
    buffer.rotate(random(2*PI));
    fractalize(radius);
    buffer.popMatrix();
    buffer.endDraw();
  }
  
  // Place PGraphics buffer on screen.
  void display(float angle){
    pushMatrix();
    translate(width/2, height/2);
    rotate(angle);
    translate(-width/2, -height/2);
    display();
    popMatrix();
  }
  void display(){
    image(buffer, -width/2, -height/2, 2*width, 2*height);
  }
  
  // Draws an n-pronged structure with arms the size of <stretch>,
  // half this arm length, and recurse downward, nesting prong
  // structures within eachother - each with arms half the length
  // of its parent.
  // 
  // The prong structures are fitted together such that two prongs
  // of each child remain in contact with two prongs of the parents
  // prongs.
  private void fractalize(float stretch){
    if(stretch < precision){
      return; 
    }
    prongs(stretch);
  
    buffer.pushMatrix();
    for(int i = 0; i < dimension; ++i){
      buffer.rotate(angle);
      buffer.pushMatrix();
      buffer.translate(stretch/2.0, 0);
      buffer.rotate(angle);
      buffer.translate(stretch/2, 0);
      buffer.rotate(PI);
      fractalize(stretch/2.0);
      buffer.popMatrix();
    }
    buffer.popMatrix();
  }
  
  // Draws n-pronged structure to the PGraphics buffer. This is 
  // performed at each step of recursion, with lines decreasing
  // length each time. <stretch> is line length.
  private void prongs(float stretch){
    buffer.fill(255);
    buffer.ellipse(0, 0, stretch/10, stretch/10);
    buffer.pushMatrix();
    for(int i = 0; i < dimension; ++i){
      buffer.stroke(painter.paint(stretch));
      buffer.line(0, 0, stretch, 0);
    
      // Draw some circles to make things look nicer. These four 
      // lines aren't really necessary - commenting them out won't
      // break anything.
      buffer.ellipse(-stretch, 0, stretch/10.0, stretch/10.0);
      buffer.ellipse(stretch, 0, stretch/10.0, stretch/10.0);
      buffer.ellipse(0, stretch, stretch/10.0, stretch/10.0);
      buffer.ellipse(0, -stretch, stretch/10.0, stretch/10.0);
    
      buffer.rotate(angle); 
    }
    buffer.popMatrix(); 
  }
  
  // Crops and saves image.
  void saveTo(String path){
    if(!path.endsWith(".png"))
      path += ".png";
    cropped().save(path);
  }
  
  // Generates a cropped and padded image of the lattice
  // buffer. Without this, there's a whole lot of extra
  // background space. With it, saved images look nice 
  // and fitting to their frames.
  private PImage cropped(){
    int s = 60;
    int lm = leftMost();
    int tm = topMost();
    int l = max(0, lm - s);
    int t = max(0, tm - s);
    return buffer.get(l, t, buffer.width - 2*l, buffer.height - 2*t);
  }
    
  // Finds location of the left-most non-black pixel on the
  // lattice. This is used for auto-cropping.
  private int leftMost(){
    buffer.loadPixels();
    for(int i = 0; i < buffer.width/2; i += 2){
      for(int j = 0; j < buffer.height; j += 2){
        if(buffer.pixels[i + j*buffer.width] != black)
          return i;
      }
    }
    return 0;
  }
  
  // Finds location of the highest non-black pixel on the
  // lattice. This is used for auto-cropping.
  private int topMost(){
    buffer.loadPixels();
    for(int j = 0; j < buffer.height/2; j += 2){
      for(int i = 0; i < buffer.width; i += 2){
        if(buffer.pixels[i + j*buffer.width] != black)
          return j;
      }
    }
    return 0;
  }
}


  
