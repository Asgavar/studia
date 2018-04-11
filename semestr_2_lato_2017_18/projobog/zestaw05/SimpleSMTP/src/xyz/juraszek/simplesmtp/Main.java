package xyz.juraszek.simplesmtp;

import javax.mail.MessagingException;

public class Main {

    public static void main(String[] args) throws MessagingException {

      SmtpFacade smtpFacade = new SmtpFacade(
          "smtp.gmail.com",
          "eligiusz.karaczewski@gmail.com",
          "calkiemdlugiehaselko"
      );

      smtpFacade.send(
          "eligiusz.karaczewski@gmail.com",
          "artur@juraszek.xyz",
          "Temat testowy",
          "Ciało testowe",
          null,
          "N/A"
          );
    }
}
