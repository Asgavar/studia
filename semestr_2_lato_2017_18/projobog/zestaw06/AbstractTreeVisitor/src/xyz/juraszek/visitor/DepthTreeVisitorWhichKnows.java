package xyz.juraszek.visitor;

public class DepthTreeVisitorWhichKnows extends TreeVisitorWhichKnows {
  private int measuredDepth;

  public DepthTreeVisitorWhichKnows() {
    this.measuredDepth = 0;
  }

  @Override
	public void visitLeaf(TreeLeaf leaf) {
    // do nothing
	}

	@Override
	public void visitNode(TreeNode node) {
    ++this.measuredDepth;
    super.visitNode(node);
	}

  public int getMeasuredDepth() {
    return this.measuredDepth;
  }
}
