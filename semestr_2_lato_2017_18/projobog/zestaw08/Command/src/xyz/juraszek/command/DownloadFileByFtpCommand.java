package xyz.juraszek.command;

public class DownloadFileByFtpCommand implements Command {
  private String filename;
  private String serverAddress;
  private FtpDownloader downloader;

  public DownloadFileByFtpCommand(FtpDownloader downloader) {
    this.downloader = downloader;
  }

  @Override
  public void setOption(CommandOption key, Object value) {
    switch (key) {
      case FTP_FILENAME:
        this.filename = (String)value;
        break;
      case FTP_SERVER_ADDRESS:
        this.serverAddress = (String)value;
        break;
    }
  }

  @Override
  public void execute() {
    this.downloader.downloadFile(this.filename, this.serverAddress);
  }
}
