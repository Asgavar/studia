package xyz.juraszek.strategy;

public class SumOfSecondColumnDataProcessingStrategy implements DataProcessingStrategy {
  private int sumOfSecondColumn = 0;

  @Override
  public void processData(String rawData) {
    for (String row : rawData.split("\n")) {
      this.sumOfSecondColumn += Integer.valueOf(row.split("\t")[1]);
    }
    System.out.println(this.sumOfSecondColumn);
  }
}
