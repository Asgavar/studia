package xyz.juraszek.extensiblefactory;

public class Main {

  public static void main(String[] args) {

    ShapeFactoryTimeRestrictionProxy factory1 = new ShapeFactoryTimeRestrictionProxy(8, 22);
    ShapeFactoryLoggingProxy factory2 = new ShapeFactoryLoggingProxy();

    factory1.registerWorker(new SquareShapeFactoryWorker());
    factory2.registerWorker(new SquareShapeFactoryWorker());

    factory1.createShape("Square",5);
    factory2.createShape("Square",5);
  }
}
