package xyz.juraszek.threesingletons;

public class OneForAllSingleton {

  private static OneForAllSingleton instance;

  private OneForAllSingleton() {

  }

  public static OneForAllSingleton getInstance() {

    if (instance == null) {
      instance = new OneForAllSingleton();
    }

    return instance;
  }
}
