package xyz.juraszek.nullobject;

public class Main {

  public static void main(String[] args) {

    Logger logger1 = LoggerFactory.getLogger(LogType.CONSOLE);
    Logger logger2 = LoggerFactory.getLogger(LogType.FILE, "~/pliczek.log");
    Logger logger3 = LoggerFactory.getLogger(LogType.NONE);

    logger1.log("coś się stało");
    logger2.log("coś się stało");
    logger3.log("coś się stało");

    logger1.log("znowu coś się stało");
    logger2.log("znowu coś się stało");
    logger3.log("znowu coś się stało");
  }
}
