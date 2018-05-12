package xyz.juraszek.visitor;

public interface TreeWhichKnows extends Tree {
  public void accept(TreeVisitor visitor);
}
