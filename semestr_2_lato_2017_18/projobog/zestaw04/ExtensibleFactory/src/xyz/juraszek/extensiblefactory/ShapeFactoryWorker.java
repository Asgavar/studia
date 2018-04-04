package xyz.juraszek.extensiblefactory;

public interface ShapeFactoryWorker {
  boolean doYouKnowHowToProduceSuchShape(String shapeName);
  Shape createShape(String shapeName, Object... creationParameters);
}
