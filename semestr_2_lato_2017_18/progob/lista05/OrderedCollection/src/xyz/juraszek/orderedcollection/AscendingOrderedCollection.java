package xyz.juraszek.orderedcollection;

import java.util.ArrayList;
import java.util.Collections;

public class AscendingOrderedCollection {

  private ArrayList<Comparable> members;

  public AscendingOrderedCollection() {
    this.members = new ArrayList<>();
  }

  public void add(Comparable element){
    this.members.add(element);
    Collections.sort(this.members);
  }

  public Comparable pop() {
    Comparable ret = this.members.get(0);
    this.members.remove(0);
    return ret;
  }

  public Comparable[] getAll() {
    return this.members.toArray(new Comparable[this.members.size()]);
  }
}
