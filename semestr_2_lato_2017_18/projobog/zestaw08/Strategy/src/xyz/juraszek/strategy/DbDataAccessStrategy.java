package xyz.juraszek.strategy;

public class DbDataAccessStrategy implements DataAccessStrategy {
  private Database db;

  public DbDataAccessStrategy(Database db) {
    this.db = db;
  }

  @Override
  public void connectToDataSource() {
    this.db.openConnection();
  }

  @Override
  public String fetchData() {
    return this.db.fetchRows();
  }

  @Override
  public void closeDataSourceConnection() {
    //
  }
}
