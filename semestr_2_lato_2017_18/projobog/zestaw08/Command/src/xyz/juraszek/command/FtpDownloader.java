package xyz.juraszek.command;

public class FtpDownloader {
  public void downloadFile(String filename, String serverAddress) {
    System.out.println("Pobieranie "+filename+" z serwera "+serverAddress+" przez FTP");
  }
}
