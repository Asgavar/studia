package xyz.juraszek.orderedcollection;

public abstract class MilitaryRank implements Comparable<MilitaryRank> {

  public abstract int getRankPriority();

  @Override
  public int compareTo(MilitaryRank o) {
    return Integer.compare(this.getRankPriority(), o.getRankPriority());
  }
}
