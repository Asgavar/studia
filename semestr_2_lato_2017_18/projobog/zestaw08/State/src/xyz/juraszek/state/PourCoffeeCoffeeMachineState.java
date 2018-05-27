package xyz.juraszek.state;

public class PourCoffeeCoffeeMachineState implements CoffeeMachineState {

  @Override
  public void sayWhatYouAreDoing(CoffeeMachine coffeMachine) {
    System.out.println("Nalewam kawę");
    coffeMachine.setState(new BeepAndSayFarewellCoffeeMachineState());
  }
}
