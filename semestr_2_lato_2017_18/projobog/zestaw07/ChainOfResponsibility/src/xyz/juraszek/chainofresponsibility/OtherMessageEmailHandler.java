package xyz.juraszek.chainofresponsibility;

public class OtherMessageEmailHandler extends EmailHandler {
  private EmailRecipient marketingDept;

  public OtherMessageEmailHandler(EmailRecipient marketingDept) {
    this.marketingDept = marketingDept;
  }

  @Override
  public void processEmail(String emailContents) {
    if (! emailContents.contains("brawo") &&
        ! emailContents.contains("karygodne") &&
        ! emailContents.contains("poproszę")) {
      this.marketingDept.receiveEmail(emailContents);
    }
    this.successor.processEmail(emailContents);
  }
}
