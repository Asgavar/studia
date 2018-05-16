package xyz.juraszek.command;

public class HttpDownloader {
  public void downloadFile(String filename, String fromServer) {
    System.out.println("Pobieranie "+filename+" z serwera "+fromServer+" przez HTTP");
  }
}
