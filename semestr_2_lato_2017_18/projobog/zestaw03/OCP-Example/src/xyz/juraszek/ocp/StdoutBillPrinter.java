package xyz.juraszek.ocp;

public class StdoutBillPrinter implements BillPrinter {

    @Override
    public void printBill(Item[] items) {
        for (Item item : items) {
            System.out.print(item.getName());
            System.out.print(": ");
            System.out.print(item.getPrice());
            System.out.println();
        }
    }
}
