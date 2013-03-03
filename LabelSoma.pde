/*
Creates the Labels for soma sliders: three labels and an auxiliary soma in the center of the sliders
The sliders does not belong to this class, they are fields of the soma class 
*/


public class LabelSoma extends Constants {
  private float x1;
  private float y1;
  private float x2;
  private float y2;
  private float x3;
  private float y3;
  private float fLength = 82;
  private float fLargeLength = 106;
  private float fRadius = 10;
  private float fHeight = 23;
  private PFont fFont;  
  private Soma auxiliarySoma;
  
  public LabelSoma(float x, float y){
    x3 = x -140;
    y3 = y+10;
    x1 = x + 80;
    y1 = y -40;
    x2 = x +10;
    y2 = y +90;
    fFont = createFont("Arial",11,true);
    auxiliarySoma = new Soma(x,y);
    
  }
  
  public void draw (){
    pushStyle();
    rectMode(CORNER);
  
    fill(350,350,350,170);
    textFont(fFont, 18);
    text("Speed", x1, y1);
  
    fill(0,0,0,0);
    stroke(350,350,350,170);
    strokeWeight(2);
    rect(x1-14, y1-17, fLength, fHeight, fRadius);
  
    fill(350,350,350,170);
    textFont(fFont, 18);
    text("Duration", x2, y2);
  
    fill(0,0,0,0);
    stroke(350,350,350,170);
    strokeWeight(2);
    rect(x2-14, y2-17, fLargeLength, fHeight, fRadius);
  
  
    fill(350,350,350,170);
    textFont(fFont, 18);
    text("Decay", x3, y3);
  
    fill(0,0,0,0);
    stroke(350,350,350,170);
    strokeWeight(2);
    rect(x3-14, y3-17, fLength, fHeight, fRadius);
    popStyle();
    auxiliarySoma.draw();
  }
  
}
