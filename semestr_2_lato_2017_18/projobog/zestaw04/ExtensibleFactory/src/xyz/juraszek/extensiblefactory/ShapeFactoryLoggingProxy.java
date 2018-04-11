package xyz.juraszek.extensiblefactory;

import java.util.Arrays;
import java.util.Calendar;

public class ShapeFactoryLoggingProxy extends ShapeFactory {

  @Override
  public void registerWorker(ShapeFactoryWorker worker) {

    this.displayStartCallLogMessage("registerWorker", worker);
    super.registerWorker(worker);
    this.displayEndCallLogMessage("registerWorker");
  }

  @Override
  public Shape createShape(String shapeName, Object... creationParameters) {

    this.displayStartCallLogMessage("createShape",creationParameters);
    Shape ret = super.createShape(shapeName, creationParameters);
    this.displayEndCallLogMessage("createShape",ret);

    return ret;
  }

  private void displayStartCallLogMessage(String methodName, Object... parameters) {
    Calendar now = Calendar.getInstance();
    System.out.println(
        "[" + now.getTime() + "] " + "Wywołano " + methodName +
            " z parametrami: " + Arrays.toString(parameters)
    );
  }

  private void displayEndCallLogMessage(String methodName, Object... results) {
    Calendar now = Calendar.getInstance();
    System.out.println(
        "[" + now.getTime() + "] " + "Zakończono wywołanie " + methodName +
            ", wyniki: " + Arrays.toString(results)
    );
  }
}
