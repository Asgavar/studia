package xyz.juraszek.threadsafebuffer;

public class ExampleProducer implements Runnable {

  private ThreadSafeBuffer buffer;
  private int putSoFar;
  private int whenToStop;
  private final Object lock;

  public ExampleProducer(ThreadSafeBuffer buffer, int whenToStop, Object lock) {
    this.buffer = buffer;
    this.putSoFar = 0;
    this.whenToStop = whenToStop;
    this.lock = lock;
  }

  private void putInBuffer() throws InterruptedException {

    synchronized (this.lock) {
      while (this.buffer.isFull()) {
        this.lock.wait();
      }

      this.buffer.put(String.valueOf(this.putSoFar));
      this.lock.notifyAll();
      System.out.println("Wstawiłem " + this.putSoFar);
      ++this.putSoFar;

    }
  }

  @Override
  public void run() {

    while (true) {

      try {
        this.putInBuffer();
      } catch (InterruptedException e) {
        //
      }

      if (this.putSoFar == this.whenToStop) {
        return;
      }

    }
  }

}
