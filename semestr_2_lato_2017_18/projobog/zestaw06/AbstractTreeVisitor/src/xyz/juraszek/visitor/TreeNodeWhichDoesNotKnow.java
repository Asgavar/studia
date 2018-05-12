package xyz.juraszek.visitor;

public class TreeNodeWhichDoesNotKnow implements TreeNode {
  private Tree leftSubtree;
  private Tree rightSubtree;

  public TreeNodeWhichDoesNotKnow(Tree leftSubtree, Tree rightSubtree) {
    this.leftSubtree = leftSubtree;
    this.rightSubtree = rightSubtree;
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
