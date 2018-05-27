package xyz.juraszek.state;

public class StartPreparingCoffeeCoffeeMachineState implements CoffeeMachineState {

  @Override
  public void sayWhatYouAreDoing(CoffeeMachine coffeMachine) {
    System.out.println("Zaczynam przyrządzać kawę");
    if (coffeMachine.getUserSugarPreference()) {
      coffeMachine.setState(new AddSugarCoffeeMachineState());
    } else {
      coffeMachine.setState(new PourCoffeeCoffeeMachineState());
    }
  }
}
