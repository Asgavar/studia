package xyz.juraszek.multithreadedMergeSort;

public class MergeSort implements Runnable {

  private int[] arrayToSort;
  private int leftBoundary;
  private int rightBoundary;

  public MergeSort(int[] arrayToSort, int leftBoundary, int rightBoundary) {
    this.arrayToSort = arrayToSort;
    this.leftBoundary = leftBoundary;
    this.rightBoundary = rightBoundary;
  }

  private void merge(int leftStart, int rightStart, int subArrayLength) {

//    int subArrayLength = (rightStart - leftStart + 1) / 2;
    int[] temporaryArray = new int[subArrayLength * 2];
    int initialLeftStart = leftStart;
    int indexInTempArray = 0;
    int leftEnd = leftStart + subArrayLength;
    int rightEnd = rightStart + subArrayLength;

    while (leftStart != leftEnd && rightStart != rightEnd) {

      if (this.arrayToSort[leftStart] <= this.arrayToSort[rightStart]) {
        temporaryArray[indexInTempArray] = this.arrayToSort[leftStart];
        ++leftStart;
      }

      else {
        temporaryArray[indexInTempArray] = this.arrayToSort[rightStart];
        ++rightStart;
      }

      ++indexInTempArray;
    }

    /* jeśli w lewej podtablicy coś pozostało */
    while (leftStart != leftEnd) {
      temporaryArray[indexInTempArray] = this.arrayToSort[leftStart];
      ++leftStart;
      ++indexInTempArray;
    }

    /* analogicznie z prawą */
    while (rightStart != rightEnd) {
      temporaryArray[indexInTempArray] = this.arrayToSort[rightStart];
      ++rightStart;
      ++indexInTempArray;
    }

    /* na koniec wklejamy tablicę tymczasową na miejsce tych dwóch podtablic */
//    System.arraycopy(temporaryArray, 0, this.arrayToSort, initialLeftStart, temporaryArray.length);
    for (int x = 0; x < temporaryArray.length; x++) {
      this.arrayToSort[initialLeftStart+x] = temporaryArray[x];
    }
  }

  @Override
  public void run() {

    if (this.rightBoundary - this.leftBoundary == 1) {
      return;
    }

    int arrayMiddle = (this.leftBoundary + this.rightBoundary) / 2;

    Thread mergeLeftSideThread = new Thread(
        new MergeSort(this.arrayToSort, this.leftBoundary, arrayMiddle)
    );

    Thread mergeRightSideThread = new Thread(
        new MergeSort(this.arrayToSort, arrayMiddle, this.rightBoundary)
    );

    /* sortujemy lewą stronę */
    try {
      mergeLeftSideThread.start();
      mergeLeftSideThread.join();
    } catch (InterruptedException e) {
      e.printStackTrace();
    }

    /* sortujemy prawą stronę */
    try {
      mergeRightSideThread.start();
      mergeRightSideThread.join();
    } catch (InterruptedException e) {
      e.printStackTrace();
    }

    /* i złączamy je w całość */
    this.merge(this.leftBoundary, arrayMiddle, arrayMiddle-this.leftBoundary);
  }

}
