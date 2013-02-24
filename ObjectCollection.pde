public class ObjectCollection extends Collection {
  private ArrayList<Path> fAxons, fDendrites;
  private ArrayList<Soma> fSomas;
  private ArrayList<Initiator> fInitiators;
  private ArrayList<Synapse> fSynapses;

  public ObjectCollection() {
    fAxons = new ArrayList<Path>();
    fDendrites = new ArrayList<Path>();
    fSomas = new ArrayList<Soma>();
    fSynapses = new ArrayList<Synapse>();
    fInitiators = new ArrayList<Initiator>();
  }
  
  public void draw(){
    for (Path p: fAxons)
      p.draw();
    for (Synapse s: fSynapses)
      s.draw(); 
    for (Path p: fDendrites)
      p.draw();
    for (Initiator i: fInitiators)
      i.draw();
    for (Soma s: fSomas)
      s.draw();
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
        return true;
      }
    }
    // if (!(key == CODED && keyCode == SHIFT))
    return false;
  }

  public boolean onMouseDragged(float x, float y) {
    for (int i = fObjs.size()-1; i>=0; i--) {
      Interactive curr = fObjs.get(i);
      if (curr.fVisible && curr.onMouseDragged(x, y)) {
        // syncAttributes(curr);
        return true;
      }
    }
    return false;
  }
}
