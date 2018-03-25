package xyz.juraszek.srp;

public class NumberedLinesReportFormatter implements ReportFormatter {

    private String rawReportString;


    public NumberedLinesReportFormatter(String rawReportString) {
        this.rawReportString = rawReportString;
    }


    @Override
    public String formatDocument() {

        String[] lines = this.rawReportString.split("\n");
        StringBuilder sb = new StringBuilder();
        int currentLineIndex = 1;

        for (String line: lines) {
            sb.append(String.valueOf(currentLineIndex));
            sb.append(". ");
            sb.append(line);
            sb.append("\n");
            ++currentLineIndex;
        }

        return sb.toString();
    }

}
