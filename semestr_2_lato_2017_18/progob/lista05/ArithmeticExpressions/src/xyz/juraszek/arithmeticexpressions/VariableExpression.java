package xyz.juraszek.arithmeticexpressions;

import java.util.Map;

public class VariableExpression implements Expression {

  private String variableName;

  public VariableExpression(String variableName) {
    this.variableName = variableName;
  }

  @Override
  public int evaluate(Map<String, Integer> variables) {
    return variables.get(this.variableName);
  }

  @Override
  public String toString() {
    return this.variableName;
  }
}
