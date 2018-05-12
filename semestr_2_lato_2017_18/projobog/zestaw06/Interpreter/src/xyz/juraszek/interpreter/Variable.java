package xyz.juraszek.interpreter;

public class Variable implements BooleanExpression {
  private String variableName;

  public Variable(String variableName) {
    this.variableName = variableName;
  }

	@Override
	public boolean evaluate(VariableValuation variableValuation) {
    try {
      return variableValuation.getVariableValue(this.variableName);
    } catch (NullPointerException e) {
      throw new UndefinedVariableException();
    }
	}
}
