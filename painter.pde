class Painter{
  float rc, gc, bc;
  
  Painter(){
    rc = random(12);
    gc = random(12);
    bc = random(12);
  }
  
  color paint(float s){
    return color(rc*s, gc*s, bc*s);
  }
}
