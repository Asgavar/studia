package xyz.juraszek.threesingletons.tests;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import xyz.juraszek.threesingletons.OnePerFiveSecondsSingleton;

class OnePerFiveSecondsSingletonTest {

  @Test
  void subsequentCallsShouldReturnSameInstance() {

    OnePerFiveSecondsSingleton first = OnePerFiveSecondsSingleton.getInstance();
    OnePerFiveSecondsSingleton second = OnePerFiveSecondsSingleton.getInstance();

    assertEquals(first, second);
  }

  @Test
  void afterTenSecondsDifferentInstanceShouldBeReturned() throws InterruptedException {

    OnePerFiveSecondsSingleton first = OnePerFiveSecondsSingleton.getInstance();
    Thread.sleep(10_000);
    OnePerFiveSecondsSingleton second = OnePerFiveSecondsSingleton.getInstance();

    assertNotEquals(first, second);
  }
}