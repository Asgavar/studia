package xyz.juraszek.orderedcollection;

public class Main {

  public static void main(String[] args) {

    AscendingOrderedCollection ranks = new AscendingOrderedCollection();

    ranks.add(new StarszySzeregowy());
    ranks.add(new Podporucznik());
    ranks.add(new Chorąży());
    ranks.add(new Szeregowy());

    System.out.println("Wyciągamy stopnie po kolei:");

    // TODO: czemu to nie dziala?
//    for (int x = 0; x < ranks.getAll().length; x++)
    for (int x = 0; x < 4; x++)
      System.out.println(ranks.pop());
  }
}

