GUI gui;
Generator generator;

void setup() {  
  size(700, 500);
  gui = new GUI(this);
  generator = new Generator();
}


void draw(){
  background(0);
  if(generator.prepared())
    generator.display();
  else
    generator.loading();
}


public void skip(int n) {
  if(generator.prepared())
    generator.discard();
}

public void save(int n) {
  println("TODO...");
}


