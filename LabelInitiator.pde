/*
Creates the Labels for initiator sliders: three labels and an auxiliary initiator in the center of the sliders
The sliders does not belong to this class, they are fields of the initiator class 
*/

public class LabelInitiator extends Constants {
  private float x1;
  private float y1;
  private float x2;
  private float y2;
  private float x3;
  private float y3;
  private float fLength = 82;
  private float fLargeLength = 120;
  private float fSmallLength = 75;
  private float fRadius = 10;
  private float fHeight = 23;
  private PFont fFont;  
  private Initiator auxiliaryInitiator;
  
  public LabelInitiator(float x, float y){
    x3 = x -140;
    y3 = y+10;
    x1 = x + 80;
    y1 = y -40;
    x2 = x +10;
    y2 = y +90;
    fFont = createFont("Arial",11,true);
    auxiliaryInitiator = new Initiator(650,580,SOMA_SIZE,EX_COLOR);
    
  }
  
  public void draw (){
    pushStyle();
    rectMode(CORNER);
  
    fill(350,350,350,170);
    textFont(fFont, 18);
    text("Rythm", x1, y1);
  
    fill(0,0,0,0);
    stroke(350,350,350,170);
    strokeWeight(2);
    rect(x1-14, y1-17, fLength, fHeight, fRadius);
  
    fill(350,350,350,170);
    textFont(fFont, 18);
    text("Frequency", x2, y2);
  
    fill(0,0,0,0);
    stroke(350,350,350,170);
    strokeWeight(2);
    rect(x2-14, y2-17, fLargeLength, fHeight, fRadius);
  
  
    fill(350,350,350,170);
    textFont(fFont, 18);
    text("Burst", x3, y3);
  
    fill(0,0,0,0);
    stroke(350,350,350,170);
    strokeWeight(2);
    rect(x3-14, y3-17, fSmallLength, fHeight, fRadius);
    popStyle();
    auxiliaryInitiator.draw();
  }
  
}
