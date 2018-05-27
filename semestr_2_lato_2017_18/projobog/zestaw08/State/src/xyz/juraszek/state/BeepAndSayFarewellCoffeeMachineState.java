package xyz.juraszek.state;

public class BeepAndSayFarewellCoffeeMachineState implements CoffeeMachineState {

  @Override
  public void sayWhatYouAreDoing(CoffeeMachine coffeMachine) {
    System.out.println("Dziękujemy za skorzystanie z naszych usług");
    coffeMachine.markTransactionAsFinished();
  }
}
