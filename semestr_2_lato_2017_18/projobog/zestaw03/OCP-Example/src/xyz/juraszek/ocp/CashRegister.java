package xyz.juraszek.ocp;

import java.math.BigDecimal;
import java.util.ArrayList;

public class CashRegister {

    private BillPrinter printer;
    private ItemOrder itemOrder;
    private TaxCalculator taxCalc;
    private ArrayList<Item> items;


    public CashRegister(BillPrinter printer, ItemOrder itemOrder, TaxCalculator taxCalc) {
        this.printer = printer;
        this.itemOrder = itemOrder;
        this.taxCalc = taxCalc;
        this.items = new ArrayList<>();
    }


    public void addItem(String name, double price) {
        this.items.add(new Item(name, new BigDecimal(price)));
    }


    public BigDecimal calculatePriceWithTax() {

        BigDecimal sum = new BigDecimal(0);

        for (Item item : items) {
            sum = sum.add(item.getPrice());
        }

        return sum.add(this.taxCalc.calculateTax(sum));
    }


    public void printBill() {
        this.printer.printBill(this.itemOrder.getItemsInOrder(
                this.items.toArray(new Item[items.size()]))
        );
    }
}
