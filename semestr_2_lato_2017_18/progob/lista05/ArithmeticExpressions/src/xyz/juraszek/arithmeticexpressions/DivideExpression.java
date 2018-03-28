package xyz.juraszek.arithmeticexpressions;

import java.util.Map;

public class DivideExpression implements Expression {

  private Expression dividend;
  private Expression divisor;

  public DivideExpression(Expression dividend, Expression divisor) {
    this.dividend = dividend;
    this.divisor = divisor;
  }

  @Override
  public int evaluate(Map<String, Integer> variables) {
    return this.dividend.evaluate(variables) / this.divisor.evaluate(variables);
  }

  @Override
  public String toString() {
    return "(" + this.dividend.toString() + " / " + this.divisor.toString() + ")";
  }
}
