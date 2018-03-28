package xyz.juraszek.arithmeticexpressions;

import java.util.HashMap;

public class Main {

    public static void main(String[] args) {

      /*
       * 2 * ((7 + x) / (y - x))
       */
      Expression exprToEvaluate =
          new MultiplyExpresssion(
              new ConstantExpression(2),
              new DivideExpression(
                  new AddExpression(
                      new ConstantExpression(7),
                      new VariableExpression("x")
                  ),
                  new SubstractExpression(
                      new VariableExpression("y"),
                      new VariableExpression("x")
                  )
              )
          );

      HashMap<String, Integer> variableValues = new HashMap<>();
      variableValues.put("x", 1);
      variableValues.put("y", 2);

      int evaluationResult = exprToEvaluate.evaluate(variableValues);

      System.out.println("Wyrażenie:");
      System.out.println(exprToEvaluate.toString());
      System.out.println("I jego wyliczona wartość:");
      System.out.println(evaluationResult);
    }
}
