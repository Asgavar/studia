package xyz.juraszek.swingobjecteditor.editors;

import javax.swing.JPanel;

public abstract class AbstractBookEditor extends JPanel {
  public abstract void setup();
  public abstract void setFileName(String fileName);
}
