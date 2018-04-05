package xyz.juraszek.threadsafebuffer;

public class ExampleConsumer implements Runnable {

  private ThreadSafeBuffer buffer;
  private int readSoFar;
  private int whenToStop;
  private final Object lock;

  public ExampleConsumer(ThreadSafeBuffer buffer, int whenToStop, Object lock) {
    this.buffer = buffer;
    this.readSoFar = 0;
    this.whenToStop = whenToStop;
    this.lock = lock;
  }

  private void readFromBuffer() throws Exception {

    synchronized (this.lock) {
      while (this.buffer.isEmpty()) {
        this.lock.wait();
      }

      System.out.println("Pobrałem " + this.buffer.get());
      this.lock.notifyAll();
      ++this.readSoFar;

    }
  }

  @Override
  public void run() {

    while (true) {

      try {
        this.readFromBuffer();
      } catch (Exception e) {
        //
      }

      if (this.readSoFar == this.whenToStop) {
        return;
      }

    }
  }

}
