package xyz.juraszek.bridge;

public class EmailNotificationChannel implements NotificationChannel {

    @Override
    public void notifyPerson(Person person) {
        System.out.println("Powiadamiam emailem " + person.getName());
    }

}
