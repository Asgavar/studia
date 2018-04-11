package xyz.juraszek.extensiblefactory;

import java.util.Calendar;

public class ShapeFactoryTimeRestrictionProxy extends ShapeFactory {

  private int hourSince;
  private int hourUntil;

  public ShapeFactoryTimeRestrictionProxy(int hourSince, int hourUntil) {
    this.hourSince = hourSince;
    this.hourUntil = hourUntil;
  }

  /**
   * Jeśli ma wystawiać taki sam interfejs, to jak go przetestować?
   *
   * @param worker
   */
  @Override
  public void registerWorker(ShapeFactoryWorker worker) {

    if (! this.isTimeAppropriate()) {
      try {
        throw new Exception("Fabryka zamknięta!");
      } catch (Exception e) {
        //
      }
    }

    super.registerWorker(worker);
  }

  @Override
  public Shape createShape(String shapeName, Object... creationParameters) {

    if (! this.isTimeAppropriate()) {
      try {
        throw new Exception("Fabryka zamknięta!");
      } catch (Exception e) {
        e.printStackTrace();
      }
    }

    return super.createShape(shapeName,creationParameters);
  }

  private boolean isTimeAppropriate() {
    Calendar now = Calendar.getInstance();
    int currentHour = now.get(Calendar.HOUR_OF_DAY);
    return (this.hourSince <= currentHour) && (currentHour <= this.hourUntil);
  }
}
