// Represents a lattice color scheme. This is really simplistic
// at the moment...
class Painter{
  float rc, gc, bc;
  
  // Assign coeficients for each of RGB.
  Painter(){
    rc = random(12);
    gc = random(12);
    bc = random(12);
  }
  
  // Generate a color based on those coeficients and <s>, a value
  // for side lenth.
  color paint(float s){
    return color(rc*s, gc*s, bc*s);
  }
}
