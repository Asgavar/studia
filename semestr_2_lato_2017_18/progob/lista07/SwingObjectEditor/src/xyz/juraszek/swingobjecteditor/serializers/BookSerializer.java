package xyz.juraszek.swingobjecteditor.serializers;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import xyz.juraszek.swingobjecteditor.models.Book;

public class BookSerializer {

  public void serialize(Book prm, String filename)
      throws IOException {

    ObjectOutputStream oos = new ObjectOutputStream(
        new FileOutputStream(filename)
    );

    oos.writeObject(prm);
    oos.close();
  }

  public Book deserialize(String filename)
      throws IOException, ClassNotFoundException {

    ObjectInputStream ois = new ObjectInputStream(
        new FileInputStream(filename)
    );

    return (Book) ois.readObject();
  }
}
