package xyz.juraszek.ocp;

public class Main {

    public static void main(String[] args) {

        CashRegister cashRegister = new CashRegister(
                new StdoutBillPrinter(),
                new NameLexicographicalItemOrder(),
                new SimpleVat23TaxCalculator());

        cashRegister.addItem("przedmiotA", 12);
        cashRegister.addItem("przedmiotB", 13);
        cashRegister.addItem("przedmiotC", 14);
        cashRegister.addItem("przedmiotD", 15);

        cashRegister.printBill();

        System.out.print("Laczna cena przedmiotow to: ");
        System.out.print(cashRegister.calculatePriceWithTax());
        System.out.println();

        CashRegister anotherCashRegister = new CashRegister(
                new StdoutBillPrinter(),
                new PriceDescendingItemOrder(),
                new SimpleVat23TaxCalculator()
        );

        anotherCashRegister.addItem("przedmiotX",42);
        anotherCashRegister.addItem("przedmiotY",43);
        anotherCashRegister.addItem("przedmiotZ",44);

        anotherCashRegister.printBill();

        System.out.print("Laczna cena przedmiotow to: ");
        System.out.print(anotherCashRegister.calculatePriceWithTax());
        System.out.println();
    }
}
