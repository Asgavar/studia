package xyz.juraszek.swingobjecteditor.models;

public class Periodical extends Book {

  public Periodical(String title, String isbnNumber, String author) {
    super(title, isbnNumber, author);
  }

  @Override
  public String getRepresentation() {
    return null;
  }
}
