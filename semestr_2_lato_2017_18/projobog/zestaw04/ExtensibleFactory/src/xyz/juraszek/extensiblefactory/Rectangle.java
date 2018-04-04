package xyz.juraszek.extensiblefactory;

public class Rectangle implements Shape {

  private int width;
  private int height;

  public Rectangle(int width, int height) {
    this.width = width;
    this.height = height;
  }

  @Override
  public String introduceYourself() {
    return "Prostokąt o szerokości " + this.width + " i długości " + this.height;
  }
}
