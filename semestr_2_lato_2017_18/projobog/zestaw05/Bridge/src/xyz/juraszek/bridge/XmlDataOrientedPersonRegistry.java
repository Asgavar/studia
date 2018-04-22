package xyz.juraszek.bridge;

public class XmlDataOrientedPersonRegistry extends DataSourceOrientedPersonRegistry {

    public XmlDataOrientedPersonRegistry(NotificationChannel nc) {
        this.notificationChannel = nc;
    }

    @Override
    protected Person[] getPersonNames() {
        return new Person[] {
            new Person("XML-owy Jan Kowalski"),
            new Person("XML-owy Adam Nowak")
        };
    }

}
