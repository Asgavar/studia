package xyz.juraszek.state;

public class ReceiveCoinsCoffeeMachineState implements CoffeeMachineState {

  @Override
  public void sayWhatYouAreDoing(CoffeeMachine coffeMachine) {
    while (coffeMachine.getCoinsReceivedSoFar() < coffeMachine.getCoffeeCost()) {
      System.out.println("Wrzucono monetę");
      coffeMachine.receiveCoin();
    }
    coffeMachine.setState(new StartPreparingCoffeeCoffeeMachineState());
  }
}
