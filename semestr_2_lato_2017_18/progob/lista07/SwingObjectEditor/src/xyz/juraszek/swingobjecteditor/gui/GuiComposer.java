package xyz.juraszek.swingobjecteditor.gui;

import java.awt.Container;
import java.awt.GridLayout;
import java.util.HashMap;
import javax.swing.JFrame;
import javax.swing.JLabel;
import xyz.juraszek.swingobjecteditor.editors.AbstractBookEditor;

public class GuiComposer {

  private HashMap<String, Class> editors;

  public GuiComposer() {
    this.editors = new HashMap<>();
  }

  public void registerClassHandler(
      String className,
      Class editorClass) {

    this.editors.put(className, editorClass);
  }

  public void showEditor(String className, String fileName)
      throws IllegalAccessException, InstantiationException {

    AbstractBookEditor editorInstance =
        (AbstractBookEditor) this.editors.get(className).newInstance();
    editorInstance.setFileName(fileName);
    editorInstance.setup();

    JFrame mainFrame = new JFrame("Edycja klasy " + className);
    mainFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    Container container = mainFrame.getContentPane();
    GridLayout layout = new GridLayout(4, 2);
    container.setLayout(layout);
    container.add(editorInstance);
    container.add(
        new JLabel("Edycja obiektu klasy " + className)
    );
    mainFrame.pack();
    mainFrame.setVisible(true);
  }
}
