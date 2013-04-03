public class Synapse extends ControllableShape implements TimerSubscriber {
  private float fStrength;
  private Signal fLatestSignal;
  private Path fAxon, fDendrite;
  private Cell fInput, fOutput;
  private Timer fTimer;
  private float fNorm,fRate,fTime;
  private CircularSlider fNormSlider,fTimeSlider,fRateSlider;
  protected ArrayList<Control> fControls;
  
  private final int RATE = 0;
  private final int TIME = 1;
  private final int NORM = 2;
  private final int RANGE = 3;
  
  public Synapse(Path axon, float x, float y, color cc) {
    this(axon, x, y, cc, SYNAPSE_STRENGTH);
  }

  public Synapse(Path axon, float x, float y, color cc, float strength) {
    super(x, y, SYNAPSE_SIZE, cc);
    fStrength = strength;
    fLatestSignal = null;
    fAxon = axon;
    //BUG: Assuming src is always a cell
    if (axon != null)
      fInput = (Cell)(axon.getSrc());
    fDendrite = null;
    fOutput = null;
    fTimer = new Timer(this, SYNAPSE_TIMING, 0.5);
    fControls = new ArrayList<Control>();
    
    float controlSize = fSize + 3 * SLIDER_BAR_WIDTH;
    fNormSlider = new CircularSlider(
      SLIDER_X, SLIDER_Y, controlSize,
      0, TWO_PI/3,
      fNorm, 0, 1.0,
      NORM, this
     );
    fControls.add(fNormSlider);
    fTimeSlider = new DiscreteCircularSlider(
      SLIDER_X, SLIDER_Y, controlSize,
      TWO_PI/3, 2 * TWO_PI/3,
      fTime, 0, 1,
      TIME, this
     );
    fControls.add(fTimeSlider);
    fRateSlider = new DiscreteCircularSlider(
      SLIDER_X, SLIDER_Y, controlSize,
      2 * TWO_PI/3, TWO_PI,
      fRate, 0, 1,
      RATE, this
     );
     //all arguments except x,y and target will be replaced
     //I am currently not using this slider 
     LinearSlider slider = new LinearSlider(SLIDER_X-220, SLIDER_Y-6, 150, 13, 100, 1, 1, 0, this);
     fControls.add(slider);
     
    fControls.add(fRateSlider);
    
    fRateSlider.setMovable(false);
    fTimeSlider.setMovable(false);
    fNormSlider.setMovable(false);
    fRateSlider.setVisible(true);
    fTimeSlider.setVisible(true);
    fNormSlider.setVisible(true);

  }

  public int getType() {
    return SYNAPSE;
  }

  public Path getAxon() {
    return fAxon;
  }

  public Path getDendrite() {
    return fDendrite;
  }

  public void drawBackground() {
    pushStyle();
    noStroke();
    color c = SHADOW_COLOR;
    ring(fSize, fLoc.x + SHADOW_OFFSETX, fLoc.y + SHADOW_OFFSETY, fStrength*SYNAPSE_MULT+SYNAPSE_BASE, c);
    popStyle();
  }

  public void drawForeground() {
    pushStyle();
    noStroke();
    color c = (fHover) ? fHighlightColor : fColor;
    ring(fSize, fLoc.x, fLoc.y, fStrength*SYNAPSE_MULT+SYNAPSE_BASE, c);
    if (fSelected) drawControls();
    if (!fTimer.ended()) {
      pushStyle();
      float s = 1 - 2*abs(fTimer.getProgress() - 0.5);
      fill(lerpColor(fHighlightColor & 0xFFFFFF, fHighlightColor, s));
      // Adde slight offset to cover holes
      ellipse(fLoc.x, fLoc.y, fSize + 0.2, fSize + 0.2);
      popStyle();
    }
    popStyle();
  }
  
  public void drawControls(){
    for (Control c:fControls){
      c.draw();
    }
  }

  public void drawSelected(){
    pushStyle();
    fill(130,0,0,100);
    ellipseMode(CENTER);
    ellipse(fLoc.x,fLoc.y,22,22);
    popStyle();
  }
  
  public void update() {
    fTimer.update();
    if (fInput != null && fOutput != null) {
      float inputDiff = fInput.getCurrentFiringRate() - fInput.getAvgFiringRate();
      float outputDiff = fOutput.getCurrentFiringRate() - fOutput.getAvgFiringRate();
      fStrength += LEARNING_K * inputDiff * outputDiff;
      fStrength = constrain(fStrength, SYNAPSE_MIN_STRENGTH, SYNAPSE_MAX_STRENGTH);
    }
  }

  public boolean isComplete() {
    return fDendrite != null;
  }

  public void addPath(Path p) {
    if (!isComplete()) {
      fDendrite = p;
      // BUG: Assuming dest is always a cell
      fOutput = (Cell)(p.getDest());
    }
  }

  public void onTimerFiring(int id, int time) {
    if (fDendrite != null)
      fDendrite.addSignal(new PostsynapticPotential(
        // fLatestSignal.fSpeed,
        SIGNAL_DEFAULT_SPEED,
        ((Soma)fOutput).getLength(),
        ((Soma)fOutput).getDecay(),
        // fLatestSignal.fStrength * fStrength,
        fLatestSignal.fStrength,
        fDendrite
      ));
  }

  public void onSignal(Signal s) {
    fLatestSignal = s;
    fTimer.reset();
  }

  public boolean isInBounds(float x, float y) {
    return PVector.dist(fLoc, new PVector(x, y)) <= (fSize + fStrength);
  }

  public void onEvent(int controlID, float value) {
  }
}
