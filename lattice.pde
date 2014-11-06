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
    buffer.save(path);
  }
}
  
