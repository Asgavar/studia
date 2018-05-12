package xyz.juraszek.interpreter;

public class Negation implements BooleanExpression {
  private BooleanExpression expressionToNegate;

  public Negation(BooleanExpression expressionToNegate) {
    this.expressionToNegate = expressionToNegate;
  }

	@Override
	public boolean evaluate(VariableValuation variableValuation) {
    return (! this.expressionToNegate.evaluate(variableValuation));
	}
}
