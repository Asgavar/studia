package xyz.juraszek.ocp;

import java.math.BigDecimal;

public class SimpleVat23TaxCalculator implements TaxCalculator {

    @Override
    public BigDecimal calculateTax(BigDecimal price) {
        return price.multiply(new BigDecimal(0.23));
    }
}
