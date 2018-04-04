package xyz.juraszek.extensiblefactory;

import java.util.ArrayList;

public class ShapeFactory {

  private ArrayList<ShapeFactoryWorker> workers;

  public ShapeFactory() {
    this.workers = new ArrayList<>();
  }

  /**
   * Nowego pracownika umieszczamy na początku listy, dzięki czemu można nadpisywać
   * sposób produkcji konkretnych figur.
   *
   * @param worker
   */
  public void registerWorker(ShapeFactoryWorker worker) {
    this.workers.add(0, worker);
  }

  public Shape createShape(String shapeName, Object... creationParameters) {

    for (ShapeFactoryWorker worker : this.workers) {
      if (worker.doYouKnowHowToProduceSuchShape(shapeName)) {
        return worker.createShape(shapeName, creationParameters);
      }
    }

    throw new IllegalArgumentException("Tego kształtu nie produkujemy!");
  }

}
