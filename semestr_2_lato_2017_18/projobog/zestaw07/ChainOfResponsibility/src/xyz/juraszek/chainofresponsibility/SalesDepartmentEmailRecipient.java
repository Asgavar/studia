package xyz.juraszek.chainofresponsibility;

public class SalesDepartmentEmailRecipient implements EmailRecipient {

  @Override
  public void receiveEmail(String emailContents) {
    System.out.println("Tu dział handlowy, dostaliśmy wiadomość: " + emailContents);
  }
}
