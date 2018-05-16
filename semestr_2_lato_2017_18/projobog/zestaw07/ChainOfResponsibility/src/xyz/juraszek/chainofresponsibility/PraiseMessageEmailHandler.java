package xyz.juraszek.chainofresponsibility;

public class PraiseMessageEmailHandler extends EmailHandler {
  private EmailRecipient president;

  public PraiseMessageEmailHandler(EmailRecipient president) {
    this.president = president;
  }

  @Override
  public void processEmail(String emailContents) {
    if (emailContents.contains("brawo")) {
      this.president.receiveEmail(emailContents);
    }
    this.successor.processEmail(emailContents);
  }
}
