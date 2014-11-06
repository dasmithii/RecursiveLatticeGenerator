import controlP5.*; // library to help with UI stuff


// Two buttons: 'save' and 'next', plus a text box for the
// output path 
class GUI{
  private ControlP5 cp5;   // UI context
  private Textfield field; // output path
  
  // Make two adjacent buttons: 'save' and 'next'. Below these,
  // provide an input box where output path can be specified.
  GUI(processing.core.PApplet route){
    noStroke();
    cp5 = new ControlP5(route);  
    cp5.addButton("save")
       .setValue(0)
       .setPosition(10, 10)
       .setSize(70,50)
       .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER).setSize(15)
       ; 
    cp5.addButton("next")
       .setValue(0)
       .setPosition(90,10)
       .setSize(70,50)
       .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER).setSize(15)
       ;  
    field = cp5.addTextfield("output")
     .setPosition(10,70)
     .setSize(150,30)
     .setFont(createFont("arial",15))
     .setFocus(true)
     .setColor(color(255,0,0))
     .setText("samples")
     ;
  }
  
  // Current output path, as specified by user.
  String output(){
     return field.getText();
  }
}

// I don't remember what this is - something to do with
// ControlP5..
public void controlEvent(ControlEvent theEvent) {}

