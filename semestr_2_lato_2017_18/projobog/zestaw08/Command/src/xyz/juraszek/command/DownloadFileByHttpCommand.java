package xyz.juraszek.command;

public class DownloadFileByHttpCommand implements Command {
  private String filename;
  private String serverAddress;
  private HttpDownloader downloader;

  public DownloadFileByHttpCommand(HttpDownloader downloader) {
    this.downloader = downloader;
  }

  @Override
  public void setOption(CommandOption key, Object value) {
    switch (key) {
      case HTTP_FILENAME:
        this.filename = (String)value;
        break;
      case HTTP_SERVER_ADDRESS:
        this.serverAddress = (String)value;
        break;
    }
  }

  @Override
  public void execute() {
    this.downloader.downloadFile(this.filename, this.serverAddress);
  }
}
