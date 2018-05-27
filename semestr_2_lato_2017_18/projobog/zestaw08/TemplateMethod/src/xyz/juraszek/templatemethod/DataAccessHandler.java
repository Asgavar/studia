package xyz.juraszek.templatemethod;

public abstract class DataAccessHandler {
  public abstract void connectToDataSource();
  public abstract void fetchData();
  public abstract void processData();
  public abstract void closeDataSourceConnection();

  public void execute() {
    this.connectToDataSource();
    this.fetchData();
    this.processData();
    this.closeDataSourceConnection();
  }
}
