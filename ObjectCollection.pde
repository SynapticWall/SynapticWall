public class ObjectCollection extends Collection {
  private ArrayList<Path> fAxons, fDendrites;
  private ArrayList<Soma> fSomas;
  private ArrayList<Initiator> fInitiators;
  private ArrayList<Synapse> fSynapses;
  LabelSoma fLabelSoma;
  LabelInitiator fLabelInitiator;

  public ObjectCollection() {
    fAxons = new ArrayList<Path>();
    fDendrites = new ArrayList<Path>();
    fSomas = new ArrayList<Soma>();
    fSynapses = new ArrayList<Synapse>();
    fInitiators = new ArrayList<Initiator>();
    fLabelSoma = new LabelSoma(650,580);
    fLabelInitiator = new LabelInitiator(650,580);
  }
  
  void checkSelected(){
    if (fSelectedObjs.size()!=0){
      Interactive a = fSelectedObjs.get(0);
      Interactive b = fSelectedObjs.get(fSelectedObjs.size()-1);
      if (a.getType()!=b.getType()){
        for (Interactive s : fSelectedObjs)
          if (s.getType()!=b.getType()) s.deselect();
        resetSelection();
        fSelectedObjs.add(b);
      }
    } 
  }
  
  void drawLabelSoma(){
    fLabelSoma.draw();
    if (fSelectedObjs.size()==1) {
      Soma a = (Soma)fSelectedObjs.get(0);
      a.drawAuxiliarySlider();
    } 
  }
  
  void drawLabelInitiator(){
    fLabelInitiator.draw(); 
  }
  
  public void draw(){
    for (Path p: fAxons)
      p.draw();
    for (Path p: fDendrites)
      p.draw();
    for (Synapse s: fSynapses)
      s.draw(); 
    for (Initiator i: fInitiators)
      i.draw();
    for (Soma s: fSomas)
      s.draw();
  }

  public void markSelected(){
    PVector p;
    for (Interactive i:fSelectedObjs){
        if (i.getType()==SOMA || i.getType()==INITIATOR){
        p = i.getLoc();
        pushStyle();
          fill(150,0,0,100);
          ellipseMode(CENTER);
          ellipse(p.x,p.y,38,38);
        popStyle();
      }
    }  
  }

  public void add(Interactive s) {
    if (s != null) {
      switch(s.getType()) {
        case DENDRITE:
          fDendrites.add((Dendrite)s);
          break;
        case AXON:
          fAxons.add((Axon)s);
          break;
        case SYNAPSE:
          fSynapses.add((Synapse)s);
          break;
        case SOMA:
          fSomas.add((Soma)s);
          break;
        case INITIATOR:
          fInitiators.add((Initiator)s);
          break;
      }
      fObjs.add(s);
    }
  }

  public void remove(Interactive s) {
    if (s != null) {
      switch(s.getType()) {
        case AXON:
        {
          Path p = (Path)s;
          Cell src = (Cell)p.getSrc();
          if (src.getRemoved()==0) src.removeAxon((Axon)s);
          fAxons.remove((Axon)s);
          remove((Interactive)((Path)s).getDest());
          break;
        }
        case DENDRITE:
        {
          Path pp = (Path)s;
          Cell dest = (Cell)pp.getDest();
          if (dest.getRemoved()==0) dest.removeDendrite((Dendrite)s);
          fDendrites.remove((Dendrite)s);
          Path path = (Path)s;
          ArrayList<Path> paths = path.getConnectedPaths();
          for (Path p : paths)
            remove((Interactive)p);
          break;
        }
        case SYNAPSE:
        {
          fSynapses.remove((Synapse)s);
          Synapse ss = (Synapse)s;
          remove((Interactive)(ss.getDendrite()));
          Axon ax = (Axon)ss.getAxon();
          fAxons.remove(ax);
          fObjs.remove((Interactive) ax);
          break;
        }
        case SOMA:
        {
          Cell cell = (Cell)s;
          cell.setRemoved();
          fSomas.remove((Soma)s);
          ArrayList<Path> axons = cell.getAxons();
          for (Path p : axons)
            remove((Interactive)p);
          ArrayList<Path> dendrites = cell.getDendrites();
          for (Path p : dendrites)
            remove((Interactive)p);   
          break;
        }
        case INITIATOR:
        {
          Cell cell = (Cell)s;
          cell.setRemoved();
          fInitiators.remove((Initiator)s);
          ArrayList<Path> axons = cell.getAxons();
          for (Path p : axons)
            remove((Interactive)p);
          ArrayList<Path> dendrites = cell.getDendrites();
          for (Path p : dendrites)
            remove((Interactive)p);
          break;
        }  
      }
      fObjs.remove(s);
    }
  }


  public boolean onMouseDown(float x, float y, int key, int keyCode) {
    boolean ok = false;
    for (int i = fObjs.size()-1; i>=0; i--) {
      Interactive curr = fObjs.get(i);
      if (curr.onMouseDown(x, y)) {
        if (curr.getType() == INITIATOR || curr.getType() == SOMA) {
          if (!fSelectedObjs.contains(curr) && curr.fVisible) {
            fSelectedObjs.add(curr);
            // @TODO: using selec to set selected state and trigger corresponding changes
            curr.select(x, y);
          }
          else if (key == CODED && keyCode == ALT) {
            fSelectedObjs.remove(curr);
          }
        }
        ok = true;
      }
    }
    // if (!(key == CODED && keyCode == SHIFT))
    return ok;
  }

  public boolean onMouseDragged(float x, float y) {
    boolean ok = false;
    for (int i = fObjs.size()-1; i>=0; i--) {
      Interactive curr = fObjs.get(i);
      if (curr.fVisible && curr.onMouseDragged(x, y)) {
        // syncAttributes(curr);
        ok = true;
      }
    }
    return ok;
  }
}
