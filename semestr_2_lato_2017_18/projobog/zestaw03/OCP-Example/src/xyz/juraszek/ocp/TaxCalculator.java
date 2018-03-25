package xyz.juraszek.ocp;

import java.math.BigDecimal;

public interface TaxCalculator {
    BigDecimal calculateTax(BigDecimal price);
}
