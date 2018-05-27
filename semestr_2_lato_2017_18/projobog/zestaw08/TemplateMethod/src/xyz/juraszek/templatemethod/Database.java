package xyz.juraszek.templatemethod;

public class Database {
  private String rows;

  public Database(String rows) {
    this.rows = rows;
  }

  public void openConnection() {
    //
  }

  public String[] fetchRows() {
    return this.rows.split("\n");
  }
}
