GUI gui;
Generator generator;

void setup() {  
  size(700, 500);
  generator = new Generator();
  gui = new GUI(this);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
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


