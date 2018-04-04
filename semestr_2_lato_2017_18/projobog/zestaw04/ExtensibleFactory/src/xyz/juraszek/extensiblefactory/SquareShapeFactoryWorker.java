package xyz.juraszek.extensiblefactory;

public class SquareShapeFactoryWorker implements ShapeFactoryWorker {

  @Override
  public boolean doYouKnowHowToProduceSuchShape(String shapeName) {
    return shapeName.equalsIgnoreCase("square");
  }

  @Override
  public Shape createShape(String shapeName, Object... creationParameters) {
    return new Square((Integer)creationParameters[0]);
  }
}
