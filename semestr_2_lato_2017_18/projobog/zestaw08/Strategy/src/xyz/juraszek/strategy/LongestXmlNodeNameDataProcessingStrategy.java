package xyz.juraszek.strategy;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class LongestXmlNodeNameDataProcessingStrategy implements DataProcessingStrategy {
  private final String xmlNodeOpeningPattern = "<[^/<>]+>";

  private ArrayList<String> nodeNames = new ArrayList<>();
  private String longestNodeName;

  @Override
  public void processData(String rawData) {
    Matcher xmlNodeOpeningMatcher =
      Pattern.compile(this.xmlNodeOpeningPattern).matcher(rawData);
    while (xmlNodeOpeningMatcher.find()) {
      this.nodeNames.add(xmlNodeOpeningMatcher.group());
    }
    this.longestNodeName =
      this.nodeNames.stream().max(Comparator.comparingInt(String::length)).get();
    System.out.println(this.longestNodeName);
  }
}
