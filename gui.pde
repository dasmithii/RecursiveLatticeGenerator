import controlP5.*;


class GUI{
  private ControlP5 cp5;
  private Textfield field;
  
  GUI(processing.core.PApplet route){
    noStroke();
    cp5 = new ControlP5(route);  
    cp5.addButton("save")
       .setValue(0)
       .setPosition(10, 10)
       .setSize(70,50)
       .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER).setSize(15)
       ; 
    cp5.addButton("skip")
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
  
  String output(){
     return field.getText();
  }
}


public void controlEvent(ControlEvent theEvent) {
}

