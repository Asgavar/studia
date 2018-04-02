package xyz.juraszek.threadsafebuffer;

public class ExampleProducer implements Runnable {

  private ThreadSafeBuffer buffer;
  private int putSoFar;
  private int whenToStop;

  public ExampleProducer(ThreadSafeBuffer buffer, int whenToStop) {
    this.buffer = buffer;
    this.putSoFar = 0;
    this.whenToStop = whenToStop;
  }

  private void putInBuffer() throws InterruptedException {

    synchronized (this) {
      while (this.buffer.isFull()) {
        this.wait();
      }

      this.buffer.put(String.valueOf(this.putSoFar));
      ++this.putSoFar;

      this.notifyAll();
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
