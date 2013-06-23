
public class LabelSynapse extends Constants {
  private int x;
  private int y;
  private PFont fFont;  
  
  public LabelSynapse(int x, int y){
    this.x = x;
    this.y = y;  
    fFont = createFont("Arial",11,true);
  }
  
  public void draw (){
      pushStyle();
      stroke(200,200,200);
      fill(0,0,0,0);
      arc(x, y, SOMA_SIZE + 5, SOMA_SIZE + 5, -PI + 0.19, PI - 0.19);
      line(x - 70, y - 6, x - 61, y - 6); 
      line(x -52, y - 6, x - 36, y - 6);
      stroke(100,100,100);
      line(x - 70,y + 6, x - 61, y + 6);
      line(x - 52,y + 6, x - 36, y + 6);
      strokeWeight(PATH_WIDTH);
      stroke(EX_COLOR);
      float s = SOMA_SIZE - SOMA_RING_WIDTH;
      line (x,y,x,y-s);
      float ss = 10;
      noStroke();
      fill(EX_COLOR);
      ellipse(x , y , ss, ss);
      noStroke();
      color c = SHADOW_COLOR;
      ring(s, x + SHADOW_OFFSETX, y + SHADOW_OFFSETY, SYNAPSE_RING_WIDTH, c);

      s = SOMA_SIZE - SOMA_RING_WIDTH;
      noStroke();
      c = EX_HIGHLIGHT_COLOR;
      ring(s, x, y, SYNAPSE_RING_WIDTH, c);
      
      popStyle();
  }
}
