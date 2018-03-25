package xyz.juraszek.srp;

public class ConstantReportDataProvider implements ReportDataProvider{

    @Override
    public String getData() {
        return "Pierwszy wiersz raportu\nDrugi wiersz\nTrzeci wiersz owego dokumentu";
    }
}
