package xyz.juraszek.bridge;

public class Main {
    public static void main(String[] args) {

        DataSourceOrientedPersonRegistry pr1 = new XmlDataOrientedPersonRegistry(new SmsNotificationChannel());
        DataSourceOrientedPersonRegistry pr2 = new XmlDataOrientedPersonRegistry(new EmailNotificationChannel());
        DataSourceOrientedPersonRegistry pr3 = new DbDataOrientedPersonRegistry(new SmsNotificationChannel());
        DataSourceOrientedPersonRegistry pr4 = new DbDataOrientedPersonRegistry(new EmailNotificationChannel());

        pr1.notifyEveryone();
        pr2.notifyEveryone();
        pr3.notifyEveryone();
        pr4.notifyEveryone();

        NotificationOrientedPersonRegistry pr5 = new SmsNotifyingPersonRegistry(new XmlPersonNamesSource());
        NotificationOrientedPersonRegistry pr6 = new SmsNotifyingPersonRegistry(new DbPersonNamesSource());
        NotificationOrientedPersonRegistry pr7 = new EmailNotifyingPersonRegistry(new XmlPersonNamesSource());
        NotificationOrientedPersonRegistry pr8 = new EmailNotifyingPersonRegistry(new DbPersonNamesSource());

        pr5.notifyEveryone();
        pr6.notifyEveryone();
        pr7.notifyEveryone();
        pr8.notifyEveryone();
    }
}
