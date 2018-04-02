package xyz.juraszek.threadsafebuffer;

import java.util.ArrayList;

public class ThreadSafeBuffer<T> {

  private final int bufferSize;
  private ArrayList<T> innerList;

  public ThreadSafeBuffer(int bufferSize) {
    this.bufferSize = bufferSize;
    this.innerList = new ArrayList<>(bufferSize);
  }

  public synchronized void put(T element) {
    this.innerList.add(element);
  }

  public synchronized T get() throws Exception {

    if (this.innerList.size() == 0) {
      throw new Exception("Bufor był pusty!");
    }

    /* usuwamy i zwracamy element z początku */
    return this.innerList.remove(0);
  }

  public boolean isEmpty() {
    return this.innerList.size() == 0;
  }

  public boolean isFull() {
    return this.innerList.size() == this.bufferSize;
  }

}
