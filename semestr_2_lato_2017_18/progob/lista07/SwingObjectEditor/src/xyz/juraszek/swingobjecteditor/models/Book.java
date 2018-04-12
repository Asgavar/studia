package xyz.juraszek.swingobjecteditor.models;

import java.io.Serializable;

public class Book implements Model, Serializable {

  private String title;
  private String author;
  private String isbnNumber;

  public Book(String title, String isbnNumber, String author) {
    this.title = title;
    this.author = author;
    this.isbnNumber = isbnNumber;
  }

  public String toString() {
    return "\"" + this.title + "\" autorstwa " + this.author + ", ISBN: " + this.isbnNumber;
  }

  @Override
  public String getRepresentation() {
    return this.toString();
  }

  public String getAuthor() {
    return author;
  }

  public String getTitle() {
    return title;
  }

  public String getIsbnNumber() {
    return isbnNumber;
  }
}
