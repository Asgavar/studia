package xyz.juraszek.swingobjecteditor.editors;

import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JTextField;
import xyz.juraszek.swingobjecteditor.models.Book;
import xyz.juraszek.swingobjecteditor.serializers.BookSerializer;

public class BookEditor extends AbstractBookEditor implements ActionListener {

  private JTextField bookNameTextArea;
  private JTextField authorTextArea;
  private JTextField isbNumberTextArea;
  private JButton saveButton;
  private String fileName;

  private static BookSerializer serializer =
      new BookSerializer();

  public void setFileName(String fileName) {
    this.fileName = fileName;
  }

  @Override
  public void setup() {
    this.setLayout(new GridLayout(8, 1));
    JLabel bookNameLabel = new JLabel("Tytuł");
    JLabel authorLabel = new JLabel("Autor");
    JLabel isbnLabel = new JLabel("ISBN");
    this.bookNameTextArea = new JTextField();
    this.authorTextArea = new JTextField();
    this.isbNumberTextArea = new JTextField();
    this.saveButton = new JButton();
    this.saveButton.setText("Zapisz");
    this.saveButton.addActionListener(this);
    try {
      Book deserialized = (Book) BookEditor.serializer.deserialize(this.fileName);
      this.bookNameTextArea.setText(deserialized.getTitle());
      this.authorTextArea.setText(deserialized.getAuthor());
      this.isbNumberTextArea.setText(deserialized.getIsbnNumber());
    } catch (Exception e) {
      // wszystko zostaje puste
      e.printStackTrace();
    }
    this.add(bookNameLabel);
    this.add(this.bookNameTextArea);
    this.add(authorLabel);
    this.add(this.authorTextArea);
    this.add(isbnLabel);
    this.add(this.isbNumberTextArea);
    this.add(saveButton);
    this.setVisible(true);
  }

  @Override
  public void actionPerformed(ActionEvent e) {
    Book newBook = new Book(this.bookNameTextArea.getText(), this.authorTextArea.getText(),
        this.isbNumberTextArea.getText());
    try {
      BookEditor.serializer.serialize(newBook, this.fileName);
      System.out.println("JUZ");
    } catch (IOException e1) {
      e1.printStackTrace();
    }
  }
}
