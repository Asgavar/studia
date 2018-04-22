package xyz.juraszek.bridge;

public class SmsNotificationChannel implements NotificationChannel {

	@Override
	public void notifyPerson(Person person) {
      System.out.println("Powiadamiam SMS-em " + person.getName());
	}

}
