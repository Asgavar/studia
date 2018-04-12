package xyz.juraszek.caesarstream;

import static org.junit.jupiter.api.Assertions.*;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class CaesarInputStreamTest {

  private FileInputStream fis;

  @BeforeEach
  void initEach() throws FileNotFoundException {
    this.fis = new FileInputStream("napisy.in");
  }

  @Test
  void testShiftingByFive() throws IOException {
    CaesarInputStream cis = new CaesarInputStream(this.fis, 5);
    int first = cis.read();
    int second = cis.read();
    int third = cis.read();
    int fourth = cis.read();

    assertAll(
        () -> assertEquals((char) first, 'f'),
        () -> assertEquals((char) second, 'g'),
        () -> assertEquals((char) third, 'h'),
        () -> assertEquals((char) fourth, 'i')
    );
  }

  @Test
  void testRecursivelyShiftingBackwards() throws IOException {
    CaesarInputStream cis = new CaesarInputStream(this.fis, 37);
    CaesarInputStream cis2 = new CaesarInputStream(cis, -37);

    int first = cis2.read();
    int second = cis2.read();
    int third = cis2.read();
    int fourth = cis2.read();

    assertAll(
        () -> assertEquals((char) first, 'a'),
        () -> assertEquals((char) second, 'b'),
        () -> assertEquals((char) third, 'c'),
        () -> assertEquals((char) fourth, 'd')
    );
  }
}