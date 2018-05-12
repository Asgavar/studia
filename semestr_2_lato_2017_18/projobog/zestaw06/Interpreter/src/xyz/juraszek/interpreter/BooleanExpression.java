package xyz.juraszek.interpreter;

public interface BooleanExpression {
  public boolean evaluate(VariableValuation variableValuation);
}
