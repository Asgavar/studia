package xyz.juraszek.threesingletons;

import java.util.HashMap;

public class OnePerThreadSingleton {

  private static HashMap<Thread, OnePerThreadSingleton> alreadyServedThreads = new HashMap<>();

  private OnePerThreadSingleton() {

  }

  public static OnePerThreadSingleton getInstance() {
    Thread threadWhichCalled = Thread.currentThread();

    if (! alreadyServedThreads.containsKey(threadWhichCalled)) {
      alreadyServedThreads.put(threadWhichCalled, new OnePerThreadSingleton());
    }

    return alreadyServedThreads.get(threadWhichCalled);
  }
}
