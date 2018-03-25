package xyz.juraszek.ocp;

import java.math.BigDecimal;

public class Item {

    private BigDecimal price;
    private String name;


    public Item(String name, BigDecimal price) {
        this.name = name;
        this.price = price;
    }


    public BigDecimal getPrice() {
        return this.price;
    }


    public String getName() {
        return this.name;
    }
}
