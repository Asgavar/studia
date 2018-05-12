package xyz.juraszek.visitor;

public interface TreeNode extends Tree {
  public Tree getLeftSubtree();
  public Tree getRightSubtree();
}
