class Lattice {
  private PGraphics buffer;
  private int dimension;
  private float precision;
  private float radius;
  private float angle;
  
  Lattice(int d, float p){
    dimension = d;
    precision = p;
    radius = width/3;
    angle = 2*PI/d;
    generate();
  }
  
  void display(){
    image(buffer, 0, 0, width, height);
  }
  
  private void generate(){
    buffer = createGraphics(width, height);
    buffer.beginDraw();
    buffer.background(0);
    buffer.pushMatrix();
    buffer.translate(width/2, height/2);
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
      buffer.stroke(10 * stretch, 3 * stretch, 3 * stretch);
      buffer.line(0, 0, stretch, 0);
    
      buffer.ellipse(-stretch, 0, stretch/10.0, stretch/10.0);
      buffer.ellipse(stretch, 0, stretch/10.0, stretch/10.0);
      buffer.ellipse(0, stretch, stretch/10.0, stretch/10.0);
      buffer.ellipse(0, -stretch, stretch/10.0, stretch/10.0);
    
      buffer.rotate(angle); 
    }
    buffer.popMatrix(); 
  }
}
  
