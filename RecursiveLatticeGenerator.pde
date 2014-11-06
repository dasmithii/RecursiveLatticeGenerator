GUI gui;
Generator generator;


// Start generating lattices and prepare the interface. 
void setup() {  
  size(700, 500);
  generator = new Generator();
  gui = new GUI(this);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
}


// If a lattice is ready, display it on the screen; otherwise,
// show a loading signal.
void draw(){
  background(0);
  if(generator.prepared())
    generator.display();
  else
    generator.loading();
}


// To be called when the 'next' button is pressed. Throws away
// the current lattice (if one exists).
public void next(int n) {
  if(generator.prepared())
    generator.discard();
}


// Saves the current lattice to disk. If the output path ends
// with '.png', it is considered a file path, and otherwise,
// a directory, in which case a random number will be 
// generated for the file name.
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
    if(path.endsWith(".png"))
      generator.saveTo(path);
    else
      saveInDirectory(file);
  }
  println("saved to: " + path);
}


// Appends random, six-digit number and '.png' to directory
// path. Writes a cropped version of the current lattice to
// file.
void saveInDirectory(File dir){
  String rand = "" + int(random(100000, 999999));
  String path = new File(dir, rand + ".png").getPath();
  generator.saveTo(path);
}

