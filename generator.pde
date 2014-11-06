import java.util.Queue;
import java.util.LinkedList;


// Maintains a limitted-size buffer of Lattices, which
// are generated in background threads (spawned during
// construction).
class Generator{
  private float angle = 0;
  private boolean stopped = false;
  Queue<Lattice> buffer;
  Lattice front = null;

  // Creates empty buffer. Spawns a few background
  // workers.
  Generator(){
    buffer = new LinkedList<Lattice>();
    int cpus = Runtime.getRuntime().availableProcessors();
    for(int i = 0; i < cpus + 2; ++i){
      worker();
    }
  }

  // Checks if at least one lattice is present.
  boolean prepared(){
    return front != null;
  }
  
  // Shows current lattice on screen. If there aren't any 
  // lattices ready, defaults to the loading screen.
  void display(){
    angle += .005;
    if(front != null){
      front.display(angle);
    }
    displayBuffer();
  }
  
  // Shows spinning 'loading...' sign to acknowledge that 
  // applet isn't frozen.
  void loading(){
    textAlign(CENTER, CENTER);
    angle += .005;
    pushMatrix();
    translate(width/2, height/2);
    rotate(angle);
    fill(250);
    textSize(30);
    text("loading...", 0, 0);
    popMatrix();
    displayBuffer();
  }
  
  // Gets rid of first lattice in buffer. Shifts forward.
  void discard(){
    synchronized (buffer) {
      front = buffer.poll();
    }
  }
  
  // Pauses background workers.
  void stop(){
    stopped = true; 
  }
  
  boolean running(){
    return !stopped; 
  }
  
  // Checks if buffer is sufficiently full.
  boolean satisfied(){
    synchronized (buffer) {
      return buffer.size() > 15;
    }
  }
  
  // Provides access to lattice buffering. Everything is 
  // done synchronized here, because there will be many
  // threads reporting concurrently.
  void report(Lattice lattice){
    synchronized (buffer) {
      if(front == null)
        front = lattice;
      else
        buffer.add(lattice);
    }
  }
  
  // Makes one worker, starting its generation task.
  private void worker(){
    Thread thread = new Worker(this);
    thread.start();
  }
  
  // Writes buffer size on screen.
  private void displayBuffer(){
    fill(250);
    textSize(20);
    textAlign(LEFT, BOTTOM);
    text("buffer: " + buffer.size(), 10, height - 10);
  }
  
  // Crops and saves current lattice. If nonexistent, does
  // nothing.
  void saveTo(String path){
    if(front != null)
      front.saveTo(path);
  }
}




// Generates lattices in the background, sending finished
// products to the parent generator. Calls Thread.sleep()
// when the generator is sufficiently buffered.
class Worker extends Thread{
  Generator parent;
  
  Worker(Generator p){
   parent = p;
  }
  
  // Called on thread start.
  public void run(){
    while(parent.running()){
      if(parent.satisfied()){
        try{
          sleep(300);
        }catch(InterruptedException e){
            System.out.println("interruption?");
        }
      } else{
        generate();
      }
    }
  }
  
  // Makes random parameters for the Lattice constructor.
  private void generate(){
    int dimension = int(random(3, 8));
    float precision = max(random(dimension-3,20), 1);
    Lattice lattice = new Lattice(dimension, precision, new Painter());
    parent.report(lattice);
  }
}
