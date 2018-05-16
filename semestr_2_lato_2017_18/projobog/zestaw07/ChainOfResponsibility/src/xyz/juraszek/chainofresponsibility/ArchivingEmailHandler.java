package xyz.juraszek.chainofresponsibility;

public class ArchivingEmailHandler extends EmailHandler {

  @Override
  public void processEmail(String emailContents) {
    System.out.println("Zarchiwizowana wiadomość: " + emailContents);
  }
}
