package xyz.juraszek.visitor;

public interface TreeVisitor {
  public void visitLeaf(TreeLeaf leaf);
  public void visitNode(TreeNode node);
}
