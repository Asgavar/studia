package xyz.juraszek.simplesmtp;

import com.sun.mail.smtp.SMTPTransport;
import java.io.InputStream;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SmtpFacade {

  private Properties properties;
  private String login;
  private String password;

  public SmtpFacade(String smtpHost, String login, String password) {
    this.properties = System.getProperties();
    this.properties.put("mail.smtp.host", smtpHost);
    this.properties.put("mail.smtp.port", "465");
    this.properties.put("mail.smtp.ssl.enable", "true");
//    this.properties.put("mail.smtps.auth", "true");
    this.login = login;
    this.password = password;
  }

  public void send(String from, String to, String subject, String body,
      InputStream attachment, String attachmentMimeType) throws MessagingException {

    Session session = Session.getDefaultInstance(this.properties, null);
    InternetAddress fromAddress = new InternetAddress(from);
    InternetAddress toAddress = new InternetAddress(to);

    Message msg = new MimeMessage(session);
    msg.setFrom(fromAddress);
    msg.setRecipient(RecipientType.TO, toAddress);
    msg.setContent(body, "text/plain");

    SMTPTransport transport = (SMTPTransport)session.getTransport("smtp");
    transport.connect(
        this.properties.getProperty("mail.smtp.host"),
        this.login,
        this.password
        );

    transport.sendMessage(msg, new InternetAddress[]{toAddress});
    System.out.println("Odpowiedź serwera: " + transport.getLastServerResponse());
    transport.close();
  }
}
