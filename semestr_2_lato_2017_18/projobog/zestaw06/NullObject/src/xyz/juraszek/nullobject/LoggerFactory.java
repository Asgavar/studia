package xyz.juraszek.nullobject;

public class LoggerFactory {

	public static Logger getLogger(LogType logType, String... parameters) {

    switch (logType) {

      case CONSOLE:
        return new ConsoleLogger();

      case FILE:
        return new FileLogger(parameters[0]);

      default:
        return new NullLogger();
    }
	}

}
