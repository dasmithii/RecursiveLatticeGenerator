class Lattice {
  private PGraphics buffer;
  private int dimension;
  private float precision;
  private float radius;
  private float angle;
  private Painter painter;
  
  Lattice(int d, float p){
    painter = new Painter();
    dimension = d;
    precision = p;
    radius = width/3.2;
    angle = 2*PI/d;
    generate();
  }
  
  void display(){
    image(buffer, -width/2, -height/2, 2*width, 2*height);
  }
  
  void display(float angle){
    pushMatrix();
    translate(width/2, height/2);
    rotate(angle);
    translate(-width/2, -height/2);
    display();
    popMatrix();
  }
  
  private void generate(){
    buffer = createGraphics(width*2, height*2);
    buffer.beginDraw();
    buffer.background(0);
    buffer.pushMatrix();
    buffer.translate(buffer.width/2, buffer.height/2);
    buffer.rotate(random(2*PI));
    fractal(radius);
    buffer.popMatrix();
    buffer.endDraw();
  }
  
  private void fractal(float stretch){
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
      fractal(stretch/2.0);
      buffer.popMatrix();
    }
    buffer.popMatrix();
  }
  
  private void prongs(float stretch){
    buffer.fill(255);
    buffer.ellipse(0, 0, stretch/10, stretch/10);
    buffer.pushMatrix();
    for(int i = 0; i < dimension; ++i){
      buffer.stroke(painter.paint(stretch));
      buffer.line(0, 0, stretch, 0);
    
      buffer.ellipse(-stretch, 0, stretch/10.0, stretch/10.0);
      buffer.ellipse(stretch, 0, stretch/10.0, stretch/10.0);
      buffer.ellipse(0, stretch, stretch/10.0, stretch/10.0);
      buffer.ellipse(0, -stretch, stretch/10.0, stretch/10.0);
    
      buffer.rotate(angle); 
    }
    buffer.popMatrix(); 
  }
  
  void saveTo(String path){
    if(!path.endsWith(".png"))
      path += ".png";
    cropped().save(path);
  }
  
  private PImage cropped(){
    int s = 60;
    int lm = leftMost();
    int tm = topMost();
    int l = max(0, lm - s);
    int t = max(0, tm - s);
    return buffer.get(l, t, buffer.width - 2*l, buffer.height - 2*t);
  }
    
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


  
