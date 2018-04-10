package xyz.juraszek.swingobjecteditor.models;

import java.io.Serializable;

public class Book implements PhysicalReadableThingModel, Serializable {

  protected String title;
  protected String author;
  protected String isbnNumber;

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
}
