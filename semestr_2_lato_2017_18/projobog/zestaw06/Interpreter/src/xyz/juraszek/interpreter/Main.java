package xyz.juraszek.interpreter;

public class Main {
  public static void main(String[] args) {
    VariableValuation variableValuation = new VariableValuation();
    variableValuation.addValue("x", true);
    variableValuation.addValue("y", false);

    BooleanExpression expressionToEvaluate =
      new Conjunction(new Variable("x"),
                      new Disjunction(new Negation(new Variable("y")),
                                      new Constant(false)));

    boolean shouldBeTrue = expressionToEvaluate.evaluate(variableValuation);
    System.out.println(shouldBeTrue);

    try {
      (new Variable("z")).evaluate(variableValuation);
    } catch (UndefinedVariableException e) {
      System.out.println("Wyjątek został słusznie rzucony");
    }
  }
}
