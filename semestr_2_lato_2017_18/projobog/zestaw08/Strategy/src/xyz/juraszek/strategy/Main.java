package xyz.juraszek.strategy;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

public class Main {
  public static void main(String[] args) {
    String exampleXmlAsString =
      "<nazwa><kolejna></kolejna><tajestnajdluzsza></tajestnajdluzsza></nazwa>";
    InputStream exampleXmlAsInputStream =
      new ByteArrayInputStream(exampleXmlAsString.getBytes(StandardCharsets.UTF_8));
    XmlDataAccessStrategy xmlDas = new XmlDataAccessStrategy(exampleXmlAsInputStream);
    LongestXmlNodeNameDataProcessingStrategy xmlDps =
      new LongestXmlNodeNameDataProcessingStrategy();
    DataAccessAndProcessingComposer xmlComposer =
      new DataAccessAndProcessingComposer(xmlDas, xmlDps);
    xmlComposer.execute();

    // 2 + 5 + 9 = 16
    Database db = new Database("1\t2\t3\n4\t5\t6\t7\n8\t9\t10");
    DbDataAccessStrategy dbDas = new DbDataAccessStrategy(db);
    SumOfSecondColumnDataProcessingStrategy dbDps =
      new SumOfSecondColumnDataProcessingStrategy();
    DataAccessAndProcessingComposer dbComposer =
      new DataAccessAndProcessingComposer(dbDas, dbDps);
    dbComposer.execute();
  }
}
