package xyz.juraszek.bridge;

public class SmsNotifyingPersonRegistry extends NotificationOrientedPersonRegistry {

    public SmsNotifyingPersonRegistry(PersonNamesSource pns) {
        this.pns = pns;
    }

    @Override
    public void notifyOne(Person person) {
        System.out.println("Powiadamiam smsem " + person.getName());
    }
}
