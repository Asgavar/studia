package xyz.juraszek.chainofresponsibility;

public abstract class EmailHandler {
  protected EmailHandler successor;

  public void setNextHandler(EmailHandler nextHandler) {
    this.successor = nextHandler;
  }

  public abstract void processEmail(String emailContents);
}
