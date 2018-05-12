package xyz.juraszek.interpreter;

import java.util.HashMap;

public class VariableValuation {
	private HashMap<String, Boolean> values;

	public VariableValuation() {
    this.values = new HashMap<>();
	}

  public void addValue(String variableName, boolean variableValue) {
    this.values.put(variableName, variableValue);
  }

  public boolean getVariableValue(String variableName) {
    return this.values.get(variableName);
  }
}
