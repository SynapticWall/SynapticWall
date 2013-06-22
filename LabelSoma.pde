/*
Creates the Labels for soma sliders: three labels and an auxiliary soma in the center of the sliders
The slider does not belong to this class, they are fields of the soma class 
*/


public class LabelSoma extends Constants {
  private float x,y;
  private float xSpeed, ySpeed, xDecay, yDecay, xDuration, yDuration;
  private int degSpeed = 260, degDecay = 120, degDuration = 30;
  private String speed = new String("Speed");
  private String decay = new String("Decay");
  private String duration = new String("Duration");
  private float offset = 5; 
  private int textHeight = 18;
  private int radius = 100;
  private int fRadius = 10;
  private PFont fFont;  
  private Soma auxiliarySoma;
  
  public LabelSoma(int x, int y){
    this.x = x;
    this.y = y;
    xSpeed = x + radius*sin(radians(degSpeed)) - (textWidth(speed) + textHeight);
    ySpeed = y + radius*cos(radians(degSpeed));
    xDecay = x + radius*sin(radians(degDecay));
    yDecay = y + radius*cos(radians(degDecay));
    xDuration = x + radius*sin(radians(degDuration));
    yDuration = y + radius*cos(radians(degDuration));
    fFont = createFont("Arial",textHeight);
    auxiliarySoma = new Soma(x,y);
    
  }
  
  
  public void draw (){
    pushStyle();
    rectMode(CORNER);
    textFont(fFont);
    stroke(180);
    strokeWeight(2);
          
    fill(350,350,350,170);
    text(speed, xSpeed, ySpeed);
    fill(0,0,0,0);
    rect(xSpeed-textHeight/2, ySpeed - textHeight, textWidth(speed) + textHeight, textHeight + offset, fRadius);
  
    fill(350,350,350,170);
    text(decay, xDecay, yDecay);
    fill(0,0,0,0);
    rect(xDecay-textHeight/2, yDecay - textHeight, textWidth(decay) + textHeight, textHeight + offset, fRadius);
  
  
    fill(350,350,350,170);
    text(duration, xDuration, yDuration);
    fill(0,0,0,0);
    rect(xDuration-textHeight/2, yDuration - textHeight, textWidth(duration) + textHeight, textHeight + offset, fRadius);
    
    popStyle();
    auxiliarySoma.draw();
  }
  
}
