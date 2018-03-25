package xyz.juraszek.ocp;

import java.util.Arrays;
import java.util.Comparator;

public class NameLexicographicalItemOrder implements ItemOrder {

    @Override
    public Item[] getItemsInOrder(Item[] items) {
        Item[] sorted = items.clone();
        Arrays.sort(sorted, Comparator.comparing(Item::getName));

        return sorted;
    }
}
