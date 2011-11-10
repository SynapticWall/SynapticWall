class PostsynapticPotential extends Signal {
  color fSignalColor;
  float fSize;
  PostsynapticPotential(float speed, float length, float strength, float mult, Path p) {
    super((strength >= 0) ? Constants.EPSP : Constants.IPSP, speed, length, strength, p);
    fStrength *= mult;
    fSize = Constants.SIGNAL_WIDTH*mult;
    fSignalColor = (fStrength >= 0) ? Constants.EX_COLOR : Constants.IN_COLOR;
  }

  void draw() {
    pushStyle();
      strokeWeight(Constants.DENDRITE_WIDTH);
      int offset = (int)(fSize/Constants.SIGNAL_RESOLUTION);
      PVector begin, end;
      int t1 = round(constrain(fCurrIndex - offset - fLength, 0, fEndIndex));
      int t2 = round(constrain(fCurrIndex - offset, 0, fEndIndex));
      int t3 = round(constrain(fCurrIndex + offset, 0, fEndIndex));
      int t4 = round(constrain(fCurrIndex + offset + fLength, 0, fEndIndex));

      for (int i = t1, j = t4-1; i < t2 && j >= t3; ++i, --j) {
        stroke(lerpColor(fColor, fSignalColor, float(i-t1)/(t2-t1)));
        begin = fPath.fVertices.get(i);
        end = fPath.fVertices.get(i+1);
        line(begin.x, begin.y, end.x, end.y);
        begin = fPath.fVertices.get(j);
        end = fPath.fVertices.get(j+1);
        line(begin.x, begin.y, end.x, end.y);
      }

      strokeWeight(1);
      stroke(fColor);
      fill(fSignalColor);
      ellipse(fLoc.x, fLoc.y, fSize, fSize);
    popStyle();
  }
}