package xyz.juraszek.command;

import java.util.UUID;

public class RandomNewFileCreator {
  public void createNewRandomFile(String filename) {
    String newFileContents = UUID.randomUUID().toString();
    System.out.println("Utworzono nowy plik: "+filename+" o zawartości: "+newFileContents);
  }
}
