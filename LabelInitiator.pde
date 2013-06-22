/*
Creates the Labels for initiator sliders: three labels and an auxiliary initiator in the center of the sliders
The slider does not belong to this class, they are fields of the initiator class 
*/

public class LabelInitiator extends Constants {
  private float x,y;
  private float xRythm, yRythm, xFreq, yFreq, xBurst, yBurst;
  private int degRythm = 260, degFreq = 120, degBurst = 30;
  private String rythm = new String("Rythm");
  private String freq = new String("Frequency");
  private String burst = new String("Burst");
  private float offset = 5; 
  private int textHeight = 18;
  private int radius = 100;
  private int fRadius = 10;
  private PFont fFont;  
  private Initiator auxiliaryInitiator;
  
  public LabelInitiator(int x, int y){
    this.x = x;
    this.y = y;
    xRythm = x + radius*sin(radians(degRythm)) - (textWidth(rythm) + textHeight);
    yRythm = y + radius*cos(radians(degRythm));
    xFreq = x + radius*sin(radians(degFreq));
    yFreq = y + radius*cos(radians(degFreq));
    xBurst = x + radius*sin(radians(degBurst));
    yBurst = y + radius*cos(radians(degBurst));
    fFont = createFont("Arial",textHeight);
    auxiliaryInitiator = new Initiator(x,y,SOMA_SIZE,EX_COLOR);
    
  }
  
  
  public void draw (){
    pushStyle();
    rectMode(CORNER);
    textFont(fFont);
    stroke(180);
    strokeWeight(2);
          
    fill(350,350,350,170);
    text(rythm, xRythm, yRythm);
    fill(0,0,0,0);
    rect(xRythm-textHeight/2, yRythm - textHeight, textWidth(rythm) + textHeight, textHeight + offset, fRadius);
  
    fill(350,350,350,170);
    text(freq, xFreq, yFreq);
    fill(0,0,0,0);
    rect(xFreq-textHeight/2, yFreq - textHeight, textWidth(freq) + textHeight, textHeight + offset, fRadius);
  
  
    fill(350,350,350,170);
    text(burst, xBurst, yBurst);
    fill(0,0,0,0);
    rect(xBurst-textHeight/2, yBurst - textHeight, textWidth(burst) + textHeight, textHeight + offset, fRadius);
    
    popStyle();
    auxiliaryInitiator.draw();
  }
  
}
