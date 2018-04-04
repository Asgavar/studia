package xyz.juraszek.extensiblefactory;

public class RectangleShapeFactoryWorker implements ShapeFactoryWorker {

  @Override
  public boolean doYouKnowHowToProduceSuchShape(String shapeName) {
    return shapeName.equalsIgnoreCase("rectangle");
  }

  @Override
  public Shape createShape(String shapeName, Object... creationParameters) {

    int width = (Integer)creationParameters[0];
    int height = (Integer)creationParameters[1];

    return new Rectangle(width, height);
  }
}
