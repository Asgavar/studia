package xyz.juraszek.state;

public class AddSugarCoffeeMachineState implements CoffeeMachineState {

  @Override
  public void sayWhatYouAreDoing(CoffeeMachine coffeMachine) {
    System.out.println("Wsypuję cukier");
    coffeMachine.setState(new PourCoffeeCoffeeMachineState());
  }
}
