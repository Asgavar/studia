package xyz.juraszek.srp;

public class ReportComposer {

    private StdoutReportPrinter printer;

    public ReportComposer(ReportDataProvider dataSource) {
      ReportFormatter dataFormatter = new NumberedLinesReportFormatter(dataSource.getData());
      this.printer = new StdoutReportPrinter(dataFormatter);
    }

    public void printReport() {
      this.printer.printReport();
    }
}
