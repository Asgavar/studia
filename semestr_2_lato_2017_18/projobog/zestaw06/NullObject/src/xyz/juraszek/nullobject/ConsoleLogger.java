package xyz.juraszek.nullobject;

public class ConsoleLogger implements Logger {

	@Override
	public void log(String message) {
		System.out.println("Logowanie " + message + " na stdout");
	}

}
