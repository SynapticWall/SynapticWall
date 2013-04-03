
public class LabelSynapse extends Constants {
  private int x;
  private int y;
  private int x1;
  private int y1;
  private int x2;
  private int y2;
  private int x3;
  private int y3;
  private int fLength = 82;
  private int fLargeLength = 106;
  private int fRadius = 10;
  private int fHeight = 23;
  private PFont fFont;  
  
  public LabelSynapse(int x, int y){
    this.x = x;
    this.y = y;  
    x1 = x -170;
    y1 = y + 10;
    x3 = x + 80;
    y3 = y -40;
    x2 = x +10;
    y2 = y +90;
    fFont = createFont("Arial",11,true);
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
