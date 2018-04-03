package xyz.juraszek.threesingletons.tests;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import xyz.juraszek.threesingletons.OnePerThreadSingleton;

class OnePerThreadSingletonTest {

  @Test
  void sameThreadsShoulReceiveSameObject() {

    OnePerThreadSingleton firstInstance = OnePerThreadSingleton.getInstance();
    OnePerThreadSingleton secondInstance = OnePerThreadSingleton.getInstance();

    assertEquals(firstInstance, secondInstance);
  }

  @Test
  void differentThreadsShouldReceiveDifferentObjects() throws InterruptedException {

    final OnePerThreadSingleton[] instances = new OnePerThreadSingleton[2];

    Thread threadOne = new Thread() {
      @Override
      public void run() {
        instances[0] = OnePerThreadSingleton.getInstance();
      }
    };

    Thread threadTwo = new Thread() {
      @Override
      public void run() {
        instances[1] = OnePerThreadSingleton.getInstance();
      }
    };

    threadOne.start();
    threadTwo.start();

    threadOne.join();
    threadTwo.join();

    assertNotEquals(instances[0], instances[1]);
  }
}