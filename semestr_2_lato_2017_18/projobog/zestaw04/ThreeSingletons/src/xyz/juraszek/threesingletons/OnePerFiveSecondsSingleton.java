package xyz.juraszek.threesingletons;

import java.util.Calendar;

public class OnePerFiveSecondsSingleton {

  private static Calendar lastCreationHappenedAt = Calendar.getInstance();
  private static OnePerFiveSecondsSingleton instance = new OnePerFiveSecondsSingleton();

  private OnePerFiveSecondsSingleton() {

  }

  public static OnePerFiveSecondsSingleton getInstance() {

    Calendar currentTime = Calendar.getInstance();

    long creationTimeSeconds = lastCreationHappenedAt.getTime().getTime() / 1_000;
    long currentTimeSeconds = currentTime.getTime().getTime() / 1_000;

    if (currentTimeSeconds - creationTimeSeconds > 5) {
      instance = new OnePerFiveSecondsSingleton();
    }

    return instance;
  }
}
