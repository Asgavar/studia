package xyz.juraszek.srp;

public class StdoutReportPrinter implements ReportPrinter {

    private ReportFormatter formatter;


    public StdoutReportPrinter(ReportFormatter formatter) {
        this.formatter = formatter;
    }

    @Override
    public void printReport() {
        System.out.println(this.formatter.formatDocument());
    }
}
