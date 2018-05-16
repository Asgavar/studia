package xyz.juraszek.chainofresponsibility;

public class Main {
  public static void main(String[] args) {
    PresidentEmailRecipient president = new PresidentEmailRecipient();
    LegalDepartmentEmailRecipient legalDept = new LegalDepartmentEmailRecipient();
    SalesDepartmentEmailRecipient salesDept = new SalesDepartmentEmailRecipient();
    MarketingDepartmentEmailRecipient marketingDept = new MarketingDepartmentEmailRecipient();

    PraiseMessageEmailHandler praiseHandler = new PraiseMessageEmailHandler(president);
    ComplaintMessageEmailHandler complaintHandler = new ComplaintMessageEmailHandler(legalDept);
    OrderMessageEmailHandler orderHandler = new OrderMessageEmailHandler(salesDept);
    OtherMessageEmailHandler otherHandler = new OtherMessageEmailHandler(marketingDept);
    ArchivingEmailHandler archiver = new ArchivingEmailHandler();

    praiseHandler.setNextHandler(complaintHandler);
    complaintHandler.setNextHandler(orderHandler);
    orderHandler.setNextHandler(otherHandler);
    otherHandler.setNextHandler(archiver);

    praiseHandler.processEmail("świetna inwestycja, brawo");
    praiseHandler.processEmail("to karygodne, żebym musiał tyle czekać!!!");
    praiseHandler.processEmail("poproszę dwa jabłka");
    praiseHandler.processEmail("pssst, mam wiadomość dla działu marketingu");
  }
}
