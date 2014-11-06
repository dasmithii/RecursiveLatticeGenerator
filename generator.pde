import java.util.Queue;
import java.util.LinkedList;

class Generator{
  private float angle = 0;
  private boolean stopped = false;
  Queue<Lattice> buffer;
  Lattice front = null;

  
  Generator(){
    buffer = new LinkedList<Lattice>();
    int cpus = Runtime.getRuntime().availableProcessors();
    for(int i = 0; i < cpus + 1; ++i){
      worker();
    }
  }

  boolean prepared(){
    return front != null;
  }
  
  
  void display(){
    angle = 0;
    if(front != null){
      front.display();
    }
  }
  
  
  void loading(){
    angle += .005;
    pushMatrix();
    translate(width/2, height/2);
    rotate(angle);
    fill(250);
    textSize(30);
    text("loading...", 0, 0);
    popMatrix();
  }
  
  void discard(){
    synchronized (buffer) {
      front = buffer.poll();
    }
  }
  
  boolean running(){
    return !stopped; 
  }
  
  void stop(){
    stopped = true; 
  }
  
  boolean satisfied(){
    synchronized (buffer) {
      return buffer.size() > 15;
    }
  }
  
  void report(Lattice lattice){
    synchronized (buffer) {
      if(front == null)
        front = lattice;
      else
        buffer.add(lattice);
    }
  }
  
  void worker(){
    Thread thread = new Worker(this);
    thread.start();
  }
}




class Worker extends Thread{
  Generator parent;
  
  Worker(Generator p){
    parent = p;
  }
  
  public void run(){
    while(parent.running()){
      if(parent.satisfied()){
        try{
          sleep(750);
        }catch(InterruptedException e){
            System.out.println("interruption");
        }
      } else{
        generate();
      }
    }
  }
  
  private void generate(){
    int dimension = int(random(3,8));
    float precision = random(1,20);
    Lattice lattice = new Lattice(dimension, precision);
    parent.report(lattice);
  }
}
