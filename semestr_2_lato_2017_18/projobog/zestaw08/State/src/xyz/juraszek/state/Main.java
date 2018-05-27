package xyz.juraszek.state;

public class Main {
  public static void main(String[] args) {
    CoffeeMachine coffeeMachineWithSugarForFiveCoins =
      new CoffeeMachine(new AwaitCoffeeMachineState(), 5, true);
    CoffeeMachine coffeeMachineWithoutSugarForTenCoins =
      new CoffeeMachine(new AwaitCoffeeMachineState(), 10, false);

    System.out.println("Kawa za pięć monet z cukrem:");
    coffeeMachineWithSugarForFiveCoins.serve();
    System.out.println("Kawa za dziesięć monet bez cukru:");
    coffeeMachineWithoutSugarForTenCoins.serve();
  }
}
