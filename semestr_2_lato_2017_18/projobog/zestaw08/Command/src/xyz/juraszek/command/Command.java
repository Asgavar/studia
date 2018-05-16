package xyz.juraszek.command;

public interface Command {
  public void setOption(CommandOption key, Object value);
  public void execute();
}
