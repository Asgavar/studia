package xyz.juraszek.extensiblefactory.tests;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import xyz.juraszek.extensiblefactory.RectangleShapeFactoryWorker;
import xyz.juraszek.extensiblefactory.Shape;
import xyz.juraszek.extensiblefactory.ShapeFactory;
import xyz.juraszek.extensiblefactory.SquareShapeFactoryWorker;

class ShapeFactoryTest {

  private ShapeFactory factory;

  @BeforeEach
  void init() {
    this.factory = new ShapeFactory();
  }

  @Test
  void shouldCreateSquareAfterWorkerRegistration() {
    this.factory.registerWorker(new SquareShapeFactoryWorker());
    Shape whatWasCreated = this.factory.createShape("square", 5);
    assertEquals("Kwadrat o boku długości 5", whatWasCreated.introduceYourself());
  }

  @Test
  void shouldCreateRectangleAfterWorkerRegistration() {
    this.factory.registerWorker(new RectangleShapeFactoryWorker());
    Shape whatWasCreated = this.factory.createShape("rectangle", 4, 3);
    assertEquals(
        "Prostokąt o szerokości 4 i długości 3",
        whatWasCreated.introduceYourself()
    );
  }

  @Test
  void shouldThrowExceptionWhenTryingToCreateUnsupportedShape() {
    assertThrows(
        IllegalArgumentException.class,
        () -> this.factory.createShape("magic shape", 42)
    );
  }
}