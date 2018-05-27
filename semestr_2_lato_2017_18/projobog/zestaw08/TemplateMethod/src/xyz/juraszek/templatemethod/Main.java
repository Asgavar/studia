package xyz.juraszek.templatemethod;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

public class Main {
  public static void main(String[] args) {
    String exampleXmlAsString =
      "<nazwa><kolejna></kolejna><tajestnajdluzsza></tajestnajdluzsza></nazwa>";
    InputStream exampleXmlAsInputStream =
      new ByteArrayInputStream(exampleXmlAsString.getBytes(StandardCharsets.UTF_8));
    LongestXmlNodeNameDataAccessHandler xmlDataAccessHandler =
      new LongestXmlNodeNameDataAccessHandler(exampleXmlAsInputStream);
    xmlDataAccessHandler.execute();
    System.out.println(xmlDataAccessHandler.getLongestNodeName());

    // 2 + 5 + 9 = 16
    Database db = new Database("1\t2\t3\n4\t5\t6\t7\n8\t9\t10");
    SumOfSecondColumnDataAccsssHandler dbDataAccessHandler =
      new SumOfSecondColumnDataAccsssHandler(db);
    dbDataAccessHandler.execute();
    System.out.println(dbDataAccessHandler.getSumOfSecondColumn());
  }
}
