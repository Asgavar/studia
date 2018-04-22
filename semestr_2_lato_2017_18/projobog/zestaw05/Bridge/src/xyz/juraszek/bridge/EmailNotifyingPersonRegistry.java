package xyz.juraszek.bridge;

public class EmailNotifyingPersonRegistry extends NotificationOrientedPersonRegistry {

    public EmailNotifyingPersonRegistry(PersonNamesSource pns) {
        this.pns = pns;
    }

    @Override
    public void notifyOne(Person person) {
        System.out.println("Powiadamiam emailem " + person.getName());
    }

}
