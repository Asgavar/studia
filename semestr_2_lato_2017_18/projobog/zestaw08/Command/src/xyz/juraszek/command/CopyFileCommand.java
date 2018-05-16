package xyz.juraszek.command;

public class CopyFileCommand implements Command {
  private String fromFileName;
  private String toFileName;
  private FileCopier copier;

  public CopyFileCommand(FileCopier copier) {
    this.copier = copier;
  }

  @Override
  public void setOption(CommandOption key, Object value) {
    switch (key) {
      case COPY_FILE_FROM:
        this.fromFileName = (String)value;
        break;
      case COPY_FILE_TO:
        this.toFileName = (String)value;
        break;
    }
  }

  @Override
  public void execute() {
    this.copier.copy(this.fromFileName, this.toFileName);
  }
}
