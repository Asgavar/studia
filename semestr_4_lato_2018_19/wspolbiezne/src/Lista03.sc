/* Zadanie 1. */
class MyPair[A, B](var fst: A, var snd: B) {
  override def toString: String =
    s"(${fst.toString}, ${snd.toString})"
}

val x = new MyPair(-42, 42)

x.fst
x.snd
x.toString

x.fst = 1337
x.snd = 22137

x.fst
x.snd
x.toString

/* Zadanie 2. */
class BankAccount(initialBalance : Double) {
  private[this] var balance = initialBalance
  def checkBalance = balance
  def deposit(amount : Double) = { balance += amount; balance}
  def withdraw(amount : Double) = { balance -= amount; balance}
}

class CheckingAccount(initialBalance: Double) extends BankAccount(initialBalance) {
  override def deposit(amount: Double): Double = {
    super.deposit(amount - 1)
  }

  override def withdraw(amount: Double): Double = {
    super.withdraw(amount - 1)
  }
}

val ba = new BankAccount(42)
val ca = new CheckingAccount(42)

ba.checkBalance
ca.checkBalance

ba.withdraw(5)
ca.withdraw(5)

ba.deposit(100)
ca.deposit(100)

ba.deposit(100)
ca.deposit(100)

class SavingsAccount(initialBalance: Double) extends BankAccount(initialBalance) {
  private[this] var transactionsThisMonth = 0

  def earnMonthlyInterest: Double= {
    this.transactionsThisMonth = 0
    super.deposit(0.01 * super.checkBalance)
  }

  private[this] def commission: Int =
    if (this.transactionsThisMonth <= 3) 0 else 1

  override def deposit(amount: Double): Double = {
    this.transactionsThisMonth += 1
    super.deposit(amount - this.commission)
  }

  override def withdraw(amount: Double): Double = {
    this.transactionsThisMonth += 1
    super.withdraw(amount - this.commission)
  }
}

val sa = new SavingsAccount(100)

sa.checkBalance
sa.earnMonthlyInterest

sa.deposit(99)
sa.withdraw(5)
sa.deposit(5)
// zaczynają się prowizje => 204.0
sa.deposit(5)

// i w tym miejscu kończą
sa.earnMonthlyInterest

sa.deposit(5)

/* Zadanie 3. */
def whileLoop[A](condition: => Boolean, expression: => A): A = {
  if (condition) {
    expression
    whileLoop(condition, expression)
    expression
  }
  else expression
}

var counter = 0
whileLoop(counter < 5, counter += 1)
