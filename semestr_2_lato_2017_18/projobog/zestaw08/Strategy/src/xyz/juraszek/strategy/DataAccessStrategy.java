package xyz.juraszek.strategy;

public interface DataAccessStrategy {
  public void connectToDataSource();
  public String fetchData();
  public void closeDataSourceConnection();
}
