package xyz.juraszek.chainofresponsibility;

public class LegalDepartmentEmailRecipient implements EmailRecipient {

  @Override
  public void receiveEmail(String emailContents) {
    System.out.println("Tu dział prawny, dostaliśmy wiadomość: " + emailContents);
  }
}
