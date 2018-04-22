package xyz.juraszek.bridge;

public abstract class NotificationOrientedPersonRegistry implements PersonRegistry {

    protected PersonNamesSource pns;

    public abstract void notifyOne(Person person);

    @Override
    public void notifyEveryone() {
        for (Person person : pns.getPersonNames())
            notifyOne(person);
    }

}
