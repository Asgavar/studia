package xyz.juraszek.visitor;

public class TreeLeafWhichKnows implements TreeWhichKnows, TreeLeaf {

	@Override
	public void accept(TreeVisitor visitor) {
    visitor.visitLeaf(this);
	}
}
