package xyz.juraszek.ocp;

import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;

public class PriceDescendingItemOrder implements ItemOrder {

    @Override
    public Item[] getItemsInOrder(Item[] items) {
        Item[] sorted = items.clone();
        Arrays.sort(sorted, Collections.reverseOrder(Comparator.comparing(Item::getPrice)));

        return sorted;
    }
}
