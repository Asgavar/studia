package xyz.juraszek.visitor;

public class TreeNodeWhichKnows implements TreeWhichKnows, TreeNode {
  private TreeWhichKnows leftSubtree;
  private TreeWhichKnows rightSubtree;

  public TreeNodeWhichKnows(TreeWhichKnows leftSubtree,
                            TreeWhichKnows rightSubtree) {
    this.leftSubtree = leftSubtree;
    this.rightSubtree = rightSubtree;
  }

	@Override
	public void accept(TreeVisitor visitor) {
    visitor.visitNode(this);
    this.leftSubtree.accept(visitor);
    this.rightSubtree.accept(visitor);
	}

	@Override
	public Tree getLeftSubtree() {
    return this.leftSubtree;
	}

	@Override
	public Tree getRightSubtree() {
    return this.rightSubtree;
	}
}
