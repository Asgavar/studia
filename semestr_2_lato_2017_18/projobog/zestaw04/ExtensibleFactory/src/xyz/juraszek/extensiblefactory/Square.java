package xyz.juraszek.extensiblefactory;

public class Square implements Shape {

  private int sideLength;

  public Square(int sideLength) {
    this.sideLength = sideLength;
  }

  @Override
  public String introduceYourself() {
    return "Kwadrat o boku długości " + this.sideLength;
  }
}
