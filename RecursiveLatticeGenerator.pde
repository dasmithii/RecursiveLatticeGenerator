Lattice l;

void setup() {  
  size(500, 500);
  l = new Lattice(3, 10);
}


void draw(){
  background(0);
  l.display();
}

