package xyz.juraszek.state;

public class CoffeeMachine {
  private CoffeeMachineState state;
  private int coffeeCost;
  private int coinsReceivedSoFar;
  private boolean withSugar;
  private boolean transactionFinished;

  public CoffeeMachine(CoffeeMachineState initialState, int coffeeCost, boolean withSugar) {
    this.state = initialState;
    this.coffeeCost = coffeeCost;
    this.withSugar = withSugar;
    this.coinsReceivedSoFar = 0;
    this.transactionFinished = false;
  }

  public int getCoffeeCost() {
    return this.coffeeCost;
  }

  public int getCoinsReceivedSoFar() {
    return this.coinsReceivedSoFar;
  }

  public boolean getUserSugarPreference() {
    return this.withSugar;
  }

  public void markTransactionAsFinished() {
    this.transactionFinished = true;
  }

  public void setState(CoffeeMachineState newState) {
    this.state = newState;
  }

  public void receiveCoin() {
    ++this.coinsReceivedSoFar;
  }

  public void serve() {
    while (! this.transactionFinished) {
      this.state.sayWhatYouAreDoing(this);
    }
  }
}
