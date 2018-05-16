package xyz.juraszek.chainofresponsibility;

public class PresidentEmailRecipient implements EmailRecipient {

  @Override
  public void receiveEmail(String emailContents) {
    System.out.println("Tu prezes, otrzymałem wiadomość: " + emailContents);
  }
}
