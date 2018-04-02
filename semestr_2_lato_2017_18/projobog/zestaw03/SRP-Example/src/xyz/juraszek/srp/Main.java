package xyz.juraszek.srp;

public class Main {

    public static void main(String[] args) {

        ReportDataProvider dataProvider = new ConstantReportDataProvider();
        ReportFormatter formatter = new NumberedLinesReportFormatter(dataProvider.getData());
        ReportPrinter printer = new StdoutReportPrinter(formatter);

        printer.printReport();

        OldReportPrinter oldPrinter = new OldReportPrinter();

        oldPrinter.getData();
        oldPrinter.formatDocument();
        oldPrinter.printReport();

        new ReportComposer(dataProvider).printReport();
    }
}
