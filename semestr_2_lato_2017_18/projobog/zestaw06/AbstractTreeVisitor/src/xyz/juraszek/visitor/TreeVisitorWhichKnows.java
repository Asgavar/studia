package xyz.juraszek.visitor;

public abstract class TreeVisitorWhichKnows implements TreeVisitor {

  @Override
  public abstract void visitLeaf(TreeLeaf leaf);

  @Override
  public void visitNode(TreeNode node) {
    Tree leftSubtree = node.getLeftSubtree();
    Tree rightSubtree = node.getRightSubtree();
    if (leftSubtree instanceof TreeNode)
      this.visitNode((TreeNode)leftSubtree);
    if (rightSubtree instanceof TreeNode)
      this.visitNode((TreeNode)rightSubtree);
  }
}
