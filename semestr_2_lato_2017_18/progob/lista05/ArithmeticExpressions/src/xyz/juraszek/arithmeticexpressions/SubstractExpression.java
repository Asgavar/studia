package xyz.juraszek.arithmeticexpressions;

import java.util.Map;

public class SubstractExpression implements Expression {

  private Expression minuend;
  private Expression subtrahend;

  public SubstractExpression(Expression minuend, Expression subtrahend) {
    this.minuend = minuend;
    this.subtrahend = subtrahend;
  }

  @Override
  public int evaluate(Map<String, Integer> variables) {
    return this.minuend.evaluate(variables) - this.subtrahend.evaluate(variables);
  }

  @Override
  public String toString() {
    return "(" + this.minuend.toString() + " - " + this.subtrahend.toString() + ")";
  }
}
