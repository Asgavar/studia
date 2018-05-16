package xyz.juraszek.chainofresponsibility;

public class ComplaintMessageEmailHandler extends EmailHandler {
  private EmailRecipient legalDept;

  public ComplaintMessageEmailHandler(EmailRecipient legalDept) {
    this.legalDept = legalDept;
  }

  @Override
  public void processEmail(String emailContents) {
    if (emailContents.contains("karygodne")) {
      this.legalDept.receiveEmail(emailContents);
    }
    this.successor.processEmail(emailContents);
  }
}
