package xyz.juraszek.caesarstream;

import java.io.FileInputStream;
import java.io.IOException;

public class Main {

  public static void main(String[] args) throws IOException {

    FileInputStream fis = new FileInputStream("napisy.in");
    CaesarInputStream cis = new CaesarInputStream(fis, 5);

    while (true) {
      int shiftedLetter = cis.read();


      if (shiftedLetter == -1) {
        break;
      }

      System.out.println(
          (char) shiftedLetter
      );
    }

  }
}
