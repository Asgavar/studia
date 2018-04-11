package xyz.juraszek.caesarstream;

import java.io.IOException;
import java.io.InputStream;

public class CaesarInputStream extends InputStream {

  private InputStream decoratedStream;
  private int shift;

  public CaesarInputStream(InputStream inputStream, int shift) {
    this.decoratedStream = inputStream;
    this.shift = shift;
  }

  @Override
  public int read() throws IOException {
    int readFromDecorated = this.decoratedStream.read();

    /* wyraźnie tak wygląda oznajmienie o końcu pliku w Javie */
    if (readFromDecorated == -1) {
      return -1;
    }

    return readFromDecorated + shift;
  }
}
