package xyz.juraszek.interpreter;

public class Conjunction implements BooleanExpression {
  private BooleanExpression leftExpression;
  private BooleanExpression rightExpression;

  public Conjunction(BooleanExpression leftExpression,
                     BooleanExpression rightExpression) {
    this.leftExpression = leftExpression;
    this.rightExpression = rightExpression;
  }

  @Override
  public boolean evaluate(VariableValuation variableValuation) {
    return (this.leftExpression.evaluate(variableValuation) &&
            this.rightExpression.evaluate(variableValuation));
  }
}
