package xyz.juraszek.templatemethod;

public class SumOfSecondColumnDataAccsssHandler extends DataAccessHandler {
  private Database db;
  private String[] rows;
  private int sumOfSecondColumn;

  public SumOfSecondColumnDataAccsssHandler(Database db) {
    this.db = db;
  }

  @Override
  public void connectToDataSource() {
    this.db.openConnection();
  }

  @Override
  public void fetchData() {
    this.rows = this.db.fetchRows();
  }

  @Override
  public void processData() {
    for (String row : this.rows) {
      this.sumOfSecondColumn += Integer.valueOf(row.split("\t")[1]);
    }
  }

  @Override
  public void closeDataSourceConnection() {
    //
  }

  public int getSumOfSecondColumn() {
    return this.sumOfSecondColumn;
  }
}
