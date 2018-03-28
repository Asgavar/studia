package xyz.juraszek.arithmeticexpressions;

import java.util.Map;

public class MultiplyExpresssion implements Expression {

  private Expression multiplier;
  private Expression multiplicand;

  public MultiplyExpresssion(Expression multiplier, Expression multiplicand) {
    this.multiplier = multiplier;
    this.multiplicand = multiplicand;
  }

  @Override
  public int evaluate(Map<String, Integer> variables) {
    return this.multiplier.evaluate(variables) * this.multiplicand.evaluate(variables);
  }

  @Override
  public String toString() {
    return "(" + this.multiplier.toString() + " * " + this.multiplicand.toString() + ")";
  }
}
