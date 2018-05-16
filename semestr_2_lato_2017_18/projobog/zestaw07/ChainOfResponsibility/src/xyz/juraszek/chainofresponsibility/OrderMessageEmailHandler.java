package xyz.juraszek.chainofresponsibility;

public class OrderMessageEmailHandler extends EmailHandler {
  private EmailRecipient salesDept;

  public OrderMessageEmailHandler(EmailRecipient salesDept) {
    this.salesDept = salesDept;
  }

  @Override
  public void processEmail(String emailContents) {
    if (emailContents.contains("poproszę")) {
      this.salesDept.receiveEmail(emailContents);
    }
    this.successor.processEmail(emailContents);
  }
}
