package xyz.juraszek.visitor;

public class DepthTreeVisitorWhichDoesNotKnow implements TreeVisitor {
  private int measuredDepth;

  public DepthTreeVisitorWhichDoesNotKnow() {
    this.measuredDepth = 0;
  }

	@Override
	public void visitLeaf(TreeLeaf leaf) {
    // do nothing
	}

	@Override
	public void visitNode(TreeNode node) {
    ++this.measuredDepth;
	}

  public int getMeasuredDepth() {
    return this.measuredDepth;
  }
}
