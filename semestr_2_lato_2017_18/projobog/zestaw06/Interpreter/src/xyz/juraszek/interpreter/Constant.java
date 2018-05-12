package xyz.juraszek.interpreter;

public class Constant implements BooleanExpression {
  private boolean value;

  public Constant(boolean value) {
    this.value = value;
  }

  @Override
  public boolean evaluate(VariableValuation variableValuation) {
    return this.value;
  }
}
