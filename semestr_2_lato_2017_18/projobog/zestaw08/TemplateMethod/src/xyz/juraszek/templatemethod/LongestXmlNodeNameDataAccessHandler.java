package xyz.juraszek.templatemethod;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class LongestXmlNodeNameDataAccessHandler extends DataAccessHandler {
  private final String xmlNodeOpeningPattern = "<[^/<>]+>";

  private InputStream xmlInputStream;
  private String rawXml;
  private Matcher xmlNodeOpeningMatcher;
  private ArrayList<String> nodeNames;
  private String longestNodeName;

  public LongestXmlNodeNameDataAccessHandler(InputStream xmlInputStream) {
    this.xmlInputStream = xmlInputStream;
    this.nodeNames = new ArrayList<>();
  }

  @Override
  public void connectToDataSource() {
    try {
      byte[] rawXmlAsBytes = this.xmlInputStream.readAllBytes();
      this.rawXml = new String(rawXmlAsBytes, "UTF-8");
    } catch (Exception e) {
      //
    }
  }

  @Override
  public void fetchData() {
    this.xmlNodeOpeningMatcher =
      Pattern.compile(this.xmlNodeOpeningPattern).matcher(this.rawXml);
  }

  @Override
  public void processData() {
    while (this.xmlNodeOpeningMatcher.find()) {
      this.nodeNames.add(this.xmlNodeOpeningMatcher.group());
    }
    this.longestNodeName =
      this.nodeNames.stream().max(Comparator.comparingInt(String::length)).get();
  }

  @Override
  public void closeDataSourceConnection() {
    //
  }

  public String getLongestNodeName() {
    return this.longestNodeName;
  }
}
