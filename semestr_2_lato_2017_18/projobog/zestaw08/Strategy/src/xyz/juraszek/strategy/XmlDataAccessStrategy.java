package xyz.juraszek.strategy;

import java.io.InputStream;

public class XmlDataAccessStrategy implements DataAccessStrategy {
  private InputStream xmlInputStream;

  public XmlDataAccessStrategy(InputStream xmlInputStream) {
    this.xmlInputStream = xmlInputStream;
  }

  @Override
  public void connectToDataSource() {
    //
  }

  @Override
  public String fetchData() {
    try {
      byte[] rawXmlAsBytes = this.xmlInputStream.readAllBytes();
      return new String(rawXmlAsBytes, "UTF-8");
    } catch (Exception e) {
      return "niemożliwe!";
    }
  }

  @Override
  public void closeDataSourceConnection() {
    //
  }
}
