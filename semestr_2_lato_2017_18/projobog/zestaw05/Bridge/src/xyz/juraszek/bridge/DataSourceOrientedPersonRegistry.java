package xyz.juraszek.bridge;

public abstract class DataSourceOrientedPersonRegistry implements PersonRegistry {

    protected NotificationChannel notificationChannel;

    protected abstract Person[] getPersonNames();

    @Override
    public void notifyEveryone() {
        for (Person person : getPersonNames())
            notificationChannel.notifyPerson(person);
    }

}
