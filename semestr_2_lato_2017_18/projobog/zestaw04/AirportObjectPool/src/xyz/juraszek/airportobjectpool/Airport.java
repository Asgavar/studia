package xyz.juraszek.airportobjectpool;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.TreeSet;

public class Airport {

  private final int planesCountLimit;
  private int planesCreatedCount;
  private ArrayList<Plane> planeInstances;
  private HashSet<Plane> currentlyHandledPlanes;

  public Airport(int planesCountLimit) {
    this.planesCountLimit = planesCountLimit;
    this.planesCreatedCount = 0;
    this.planeInstances = new ArrayList<>(planesCountLimit);
    this.currentlyHandledPlanes = new HashSet<>();
  }

  public Plane getPlane() throws NoPlanesAvailableException {

    if (! isSomePlaneAvailable()) {

      if (this.planesCreatedCount < this.planesCountLimit) {
        this.planeInstances.add(new Plane());
        ++this.planesCreatedCount;

      } else {
        throw new NoPlanesAvailableException();
      }
    }

    Plane planeToHandle = this.planeInstances.remove(this.planeInstances.size() - 1);
    this.currentlyHandledPlanes.add(planeToHandle);
    return planeToHandle;
  }

  public void releasePlane(Plane plane) throws ThisPlaneIsNotFromHereException {

    if (! this.currentlyHandledPlanes.contains(plane)) {
      throw new ThisPlaneIsNotFromHereException();
    }

    this.currentlyHandledPlanes.remove(plane);
    this.planeInstances.add(plane);
  }

  private boolean isSomePlaneAvailable() {
    return this.planeInstances.size() != 0;
  }
}
