public class Collection extends Constants {
  protected ArrayList<Interactive> fObjs, fSelectedObjs;

  public Collection() {
    fObjs = new ArrayList<Interactive>();
    fSelectedObjs = new ArrayList<Interactive>();
  }

  public void reset() {
    fObjs.clear();
    resetSelection();
  }

  public void resetSelection() {
    fSelectedObjs.clear();
  }

  public void draw() {
    for (Interactive s : fObjs)
      s.draw();
  }

  public void drawAndUpdate() {
    for (Interactive s : fObjs)
      s.update();
    draw();
  }

  public boolean select(float x, float y) {
    deselectAll();
    for (int i = fObjs.size()-1; i>=0; i--) {
      Interactive s = fObjs.get(i);
      if (s.select(x, y) && s.fVisible) {
        fSelectedObjs.add(s);
        return true;
      }
    }
    return false;
  }

  public boolean selectArea(PVector start, PVector end) {
    deselectAll();
    PVector minCoord = new PVector(min(start.x, end.x), min(start.y, end.y));
    PVector maxCoord = new PVector(max(start.x, end.x), max(start.y, end.y));
    for (Interactive s : fObjs) {
      PVector p = s.getLoc();
      if (p.x >= minCoord.x && p.y >= minCoord.y &&
          p.x <= maxCoord.x && p.y <= maxCoord.y) {
        fSelectedObjs.add(s);
        // @TODO: using selec to set selected state and trigger corresponding changes
        s.select(p.x, p.y);
      }
    }
    return fSelectedObjs.size() != 0;
  }

  public void deselectAll() {
    for (Interactive s : fSelectedObjs)
      s.deselect();
    resetSelection();
  }

  public ArrayList<Interactive> getSelected() {
    return fSelectedObjs;
  }

  public void add(Interactive s) {
    fObjs.add(s);
  }

  public void remove(Interactive s) {
    fObjs.remove(s);
  }

  public boolean onMouseDown(float x, float y) {
    boolean ok = false;
    for (int i = fObjs.size()-1; i>=0; i--) {
      Interactive curr = fObjs.get(i);
      if (curr.fVisible && curr.onMouseDown(x, y)) {
        ok = true;;
      }
    }
    return ok;
  }

  public boolean onMouseDragged(float x, float y) {
    boolean ok = false;
    for (int i = fObjs.size()-1; i>=0; i--) {
      Interactive curr = fObjs.get(i);
      if (curr.fVisible && curr.onMouseDragged(x, y)) {
        ok = true;
      }
    }
    return ok;
  }

  public boolean onMouseMoved(float x, float y) {
    for (int i = fObjs.size()-1; i>=0; i--) {
      Interactive curr = fObjs.get(i);
      if (curr.fVisible && curr.onMouseMoved(x, y)) {
        return true;
      }
    }
    return false;
  }

  public boolean onMouseUp(float x, float y) {
    for (int i = fObjs.size()-1; i>=0; i--) {
      Interactive curr = fObjs.get(i);
      if (curr.fVisible && curr.onMouseUp(x, y)) {
        return true;
      }
    }
    return false;
  }

  public boolean onDblClick(float x, float y) {
    for (int i = fObjs.size()-1; i>=0; i--) {
      Interactive curr = fObjs.get(i);
      if (curr.fVisible && curr.onDblClick(x, y)) {
        return true;
      }
    }
    return false;
  }

  public boolean onSmoothToggle(boolean smooth) {
    for (int i = fObjs.size()-1; i>=0; i--) {
      Interactive curr = fObjs.get(i);
      if (curr.fVisible && curr.onSmoothToggle(smooth)) {
        return true;
      }
    }
    return false;
  }
}
