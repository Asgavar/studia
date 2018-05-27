package xyz.juraszek.state;

public class AwaitCoffeeMachineState implements CoffeeMachineState {

  @Override
  public void sayWhatYouAreDoing(CoffeeMachine coffeMachine) {
    System.out.println("Oczekuję");
    coffeMachine.setState(new ReceiveCoinsCoffeeMachineState());
  }
}
