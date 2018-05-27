package xyz.juraszek.state;

public class AskAboutSugarPreferenceCoffeeMachineState implements CoffeeMachineState {

  @Override
  public void sayWhatYouAreDoing(CoffeeMachine coffeMachine) {
    boolean doUserWantSugar = true;
    coffeMachine.setState(new StartPreparingCoffeeCoffeeMachineState());
  }
}
