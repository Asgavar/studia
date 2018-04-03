package xyz.juraszek.threesingletons.tests;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import xyz.juraszek.threesingletons.OneForAllSingleton;

class OneForAllSingletonTest {

  @Test
  void differentCallsReturnSameObject() {

    OneForAllSingleton first = OneForAllSingleton.getInstance();
    OneForAllSingleton second = OneForAllSingleton.getInstance();
    OneForAllSingleton third = OneForAllSingleton.getInstance();

    assertAll(
        () -> assertEquals(first, second),
        () -> assertEquals(first, third),
        () -> assertEquals(second, third)
    );
  }
}