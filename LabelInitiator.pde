/*
Creates the Labels for initiator sliders: three labels and an auxiliary initiator in the center of the sliders
The sliders does not belong to this class, they are fields of the initiator class 
*/

public class LabelInitiator extends Constants {
  private int x1;
  private int y1;
  private int x2;
  private int y2;
  private int x3;
  private int y3;
  private int fLength = 82;
  private int fLargeLength = 120;
  private int fSmallLength = 75;
  private int fRadius = 10;
  private int fHeight = 23;
  private PFont fFont;  
  private Initiator auxiliaryInitiator;
  
  public LabelInitiator(int x, int y){
    x3 = x -140;
    y3 = y+10;
    x2 = x + 80;
    y2 = y -40;
    x1 = x +10;
    y1 = y +90;
    fFont = createFont("Arial",11,true);
    auxiliaryInitiator = new Initiator(x,y,SOMA_SIZE,EX_COLOR);
    
  }
  
  void roundRect(int x, int y, int w, int h, int r) {

  arc(x + r, y + h -r, r, r+2, radians(180.0), radians(270.0));
  arc(x + w -r, y + h - r, r,r+2, radians(270.0), radians(360.0));
  arc(x + r, y + r, r,r+2, radians(90.0), radians(180.0));
  arc(x + w - r, y + r, r,r+2, radians(0.0), radians(90.0));
  line(x + r, y, x + w - r, y);
  line(x + r, y + h, x + w - r, y + h);
  //line(x,y + r,x,y + h - r);
  //line(x + w, y + r, x + w ,y + h - r);

 }
  
  public void draw (){
    pushStyle();
    rectMode(CORNER);
  
    fill(350,350,350,170);
    textFont(fFont, 18);
    text("Rythm", x1, y1);
  
    fill(0,0,0,0);
    stroke(180);
    strokeWeight(2);
    roundRect(x1-14, y1-17, fLength, fHeight, fRadius);
  
    fill(350,350,350,170);
    textFont(fFont, 18);
    text("Frequency", x2, y2);
  
    fill(0,0,0,0);
    roundRect(x2-14, y2-17, fLargeLength, fHeight, fRadius);
  
  
    fill(350,350,350,170);
    textFont(fFont, 18);
    text("Burst", x3, y3);
  
    fill(0,0,0,0);
    roundRect(x3-14, y3-17, fSmallLength, fHeight, fRadius);
    popStyle();
    auxiliaryInitiator.draw();
  }
  
}
