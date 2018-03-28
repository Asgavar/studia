package xyz.juraszek.arithmeticexpressions;

import java.util.Map;

public class AddExpression implements Expression {

  private Expression augend;
  private Expression addend;

  public AddExpression(Expression augend, Expression addend) {
    this.augend = augend;
    this.addend = addend;
  }

  @Override
  public int evaluate(Map<String, Integer> variables) {
    return this.augend.evaluate(variables) + this.addend.evaluate(variables);
  }

  @Override
  public String toString() {
    return "(" + this.augend.toString() + " + " + this.addend.toString() + ")";
  }
}
