int dim = 3;
float o;

void setup() {
  o = 2*PI/dim;
  size(displayWidth, displayHeight);
  background(0);
  pushMatrix();
  translate(width/2.0, height/2.0);
  rotate(PI/3.0);
  fractal(300, 10);
  popMatrix();
}


void fractal(float stretch, float precision) {
  if(stretch < precision){
    return; 
  }
  prongs(stretch);
  
  pushMatrix();
//  rotate(o/2);
  for(int i = 0; i < dim; ++i){
    rotate(o);
    pushMatrix();
    translate(stretch/2.0, 0);
    rotate(o);
    translate(stretch/2, 0);
    rotate(PI);
    fractal(stretch/2.0, precision);
    popMatrix();
  }
  popMatrix();
}


void prongs(float stretch){
  fill(255);
  ellipse(0, 0, stretch/10.0, stretch/10.0);
  pushMatrix();
  for(int i = 0; i < dim; ++i){
    stroke(10 * stretch, 3 * stretch, 3 * stretch);
    line(0, 0, stretch, 0);
    
    ellipse(-stretch, 0, stretch/10.0, stretch/10.0);
    ellipse(stretch, 0, stretch/10.0, stretch/10.0);
    ellipse(0, stretch, stretch/10.0, stretch/10.0);
    ellipse(0, -stretch, stretch/10.0, stretch/10.0);
    
    rotate(o); 
  }
  popMatrix(); 
}
