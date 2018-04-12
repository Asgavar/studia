package xyz.juraszek.swingobjecteditor;

import xyz.juraszek.swingobjecteditor.editors.BookEditor;
import xyz.juraszek.swingobjecteditor.gui.GuiComposer;

public class Main {

  public static void main(String[] args) throws InstantiationException, IllegalAccessException {
    GuiComposer gc = new GuiComposer();
    gc.registerClassHandler("Book", BookEditor.class);
    gc.showEditor("Book", "plik.txt");
  }
}
