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
  if(gui == null)
    return;
    
  String path = gui.output();
  File file = new File(path);
  if(file.exists()){
    if(file.isFile()){
      println(" - ERROR: file already exists.");
    } else{
      saveInDirectory(file);
    }
  } else{
    generator.saveTo(path);
  }
}

void saveInDirectory(File dir){
  String rand = "" + int(random(100000, 999999));
  String path = new File(dir, rand + ".png").getPath();
  generator.saveTo(path);
}

