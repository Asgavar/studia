package xyz.juraszek.chainofresponsibility;

public class MarketingDepartmentEmailRecipient implements EmailRecipient {

  @Override
  public void receiveEmail(String emailContents) {
    System.out.println("Tu dział marketingu, otrzymaliśmy wiadomość: " + emailContents);
  }
}
