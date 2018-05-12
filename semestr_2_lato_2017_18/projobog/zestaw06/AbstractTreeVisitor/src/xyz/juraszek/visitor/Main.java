package xyz.juraszek.visitor;

public class Main {
  public static void main(String [] args) {
    DepthTreeVisitorWhichKnows dtvwk = new DepthTreeVisitorWhichKnows();
    TreeNode treeWhichDoesNotKnow = new TreeNodeWhichDoesNotKnow(
        new TreeNodeWhichDoesNotKnow(
            new TreeLeafWhichDoesNotKnow(),
            new TreeNodeWhichDoesNotKnow(
                new TreeLeafWhichDoesNotKnow(),
                new TreeLeafWhichDoesNotKnow()
            )
        ),
        new TreeLeafWhichDoesNotKnow()
    );
    dtvwk.visitNode(treeWhichDoesNotKnow);
    int shouldBeThree = dtvwk.getMeasuredDepth();
    System.out.println(shouldBeThree);
  }
}
