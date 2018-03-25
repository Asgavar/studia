package xyz.juraszek.srp;

public class OldReportPrinter {

    private String reportDataString;


    public String getData() {
        return "Pierwszy wiersz raportu\nDrugi wiersz\nTrzeci wiersz owego dokumentu";
    }


    public void formatDocument() {
        String[] lines = this.getData().split("\n");
        StringBuilder sb = new StringBuilder();
        int currentLineIndex = 1;

        for (String line: lines) {
            sb.append(String.valueOf(currentLineIndex));
            sb.append(". ");
            sb.append(line);
            sb.append("\n");
            ++currentLineIndex;
        }

        this.reportDataString = sb.toString();
    }


    public void printReport() {
        System.out.println(this.reportDataString);
    }
}
