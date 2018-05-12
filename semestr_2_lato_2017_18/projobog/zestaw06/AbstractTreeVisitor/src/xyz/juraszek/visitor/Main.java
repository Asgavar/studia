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

    DepthTreeVisitorWhichDoesNotKnow dtvwdnk = new DepthTreeVisitorWhichDoesNotKnow();
    TreeWhichKnows treewhichKnows = new TreeNodeWhichKnows(
        new TreeNodeWhichKnows(
            new TreeLeafWhichKnows(),
            new TreeNodeWhichKnows(
                new TreeLeafWhichKnows(),
                new TreeNodeWhichKnows(
                    new TreeLeafWhichKnows(),
                    new TreeLeafWhichKnows()
                )
            )
        ),
        new TreeLeafWhichKnows()
    );
    treewhichKnows.accept(dtvwdnk);

    int shouldBeThree = dtvwk.getMeasuredDepth();
    System.out.println(shouldBeThree);
    int shouldBeFour = dtvwdnk.getMeasuredDepth();
    System.out.println(shouldBeFour);
  }
}
