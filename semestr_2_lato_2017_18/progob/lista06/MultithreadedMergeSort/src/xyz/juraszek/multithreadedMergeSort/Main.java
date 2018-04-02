package xyz.juraszek.multithreadedMergeSort;

import java.util.Arrays;

public class Main {

  public static void main(String[] args) throws InterruptedException {

    int[] arrayToSort = {
        9, 42, -33, 18, 27, 31
    };

    System.out.println("Przed posortowaniem: " + Arrays.toString(arrayToSort));

    Thread sortingThread = new Thread(
        new MergeSort(arrayToSort, 0, arrayToSort.length)
    );

    sortingThread.start();
    sortingThread.join();

    System.out.println("Po posortowaniu: " + Arrays.toString(arrayToSort));
  }
}
