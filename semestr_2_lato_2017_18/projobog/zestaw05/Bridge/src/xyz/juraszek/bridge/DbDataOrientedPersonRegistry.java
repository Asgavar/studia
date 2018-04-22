package xyz.juraszek.bridge;

public class DbDataOrientedPersonRegistry extends DataSourceOrientedPersonRegistry {

    public DbDataOrientedPersonRegistry(NotificationChannel nc) {
        this.notificationChannel = nc;
    }

    @Override
    protected Person[] getPersonNames() {
        return new Person[] {
            new Person("Bazodanowy Jan Kowalski"),
            new Person("Bazodanowy Adam Nowak")
        };
    }

}
