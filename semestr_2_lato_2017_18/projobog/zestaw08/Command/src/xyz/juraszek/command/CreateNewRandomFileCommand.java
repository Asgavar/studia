package xyz.juraszek.command;

public class CreateNewRandomFileCommand implements Command {
  private String filename;
  private RandomNewFileCreator creator;

  public CreateNewRandomFileCommand(RandomNewFileCreator creator) {
    this.creator = creator;
  }

  @Override
  public void setOption(CommandOption key, Object value) {
    switch (key) {
      case NEW_RANDOM_FILENAME:
        this.filename = (String)value;
        break;
    }
  }

  @Override
  public void execute() {
    this.creator.createNewRandomFile(filename);
  }
}
