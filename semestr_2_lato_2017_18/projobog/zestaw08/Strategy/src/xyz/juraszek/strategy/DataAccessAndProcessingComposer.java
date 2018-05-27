package xyz.juraszek.strategy;

public class DataAccessAndProcessingComposer {
  private DataAccessStrategy das;
  private DataProcessingStrategy dps;

  public DataAccessAndProcessingComposer(DataAccessStrategy das, DataProcessingStrategy dps) {
    this.das = das;
    this.dps = dps;
  }

  public void execute() {
    this.das.connectToDataSource();
    String rawData = this.das.fetchData();
    this.dps.processData(rawData);
    this.das.closeDataSourceConnection();
  }
}
