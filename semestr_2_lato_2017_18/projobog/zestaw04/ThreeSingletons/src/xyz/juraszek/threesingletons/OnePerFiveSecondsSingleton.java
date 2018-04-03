package xyz.juraszek.threesingletons;

import java.util.Calendar;

public class OnePerFiveSecondsSingleton {

  private static Calendar lastCreationHappenedAt = Calendar.getInstance();
  private static OnePerFiveSecondsSingleton instance = new OnePerFiveSecondsSingleton();

  private OnePerFiveSecondsSingleton() {

  }

  public static OnePerFiveSecondsSingleton getInstance() {

    Calendar currentTime = Calendar.getInstance();

    long secondsOfCreationTime = lastCreationHappenedAt.get(Calendar.SECOND);
    long secondsOfCurrentTime = currentTime.get(Calendar.SECOND);

    if (secondsOfCurrentTime - secondsOfCreationTime > 5) {
      instance = new OnePerFiveSecondsSingleton();
    }

    return instance;
  }
}
