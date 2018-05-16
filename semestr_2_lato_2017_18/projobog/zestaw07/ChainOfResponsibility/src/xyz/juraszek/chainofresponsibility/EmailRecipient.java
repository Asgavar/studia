package xyz.juraszek.chainofresponsibility;

public interface EmailRecipient {
  public void receiveEmail(String emailContents);
}
