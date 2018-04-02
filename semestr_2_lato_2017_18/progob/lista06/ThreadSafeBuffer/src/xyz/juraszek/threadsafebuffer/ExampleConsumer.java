package xyz.juraszek.threadsafebuffer;

public class ExampleConsumer implements Runnable {

  private ThreadSafeBuffer buffer;
  private int readSoFar;
  private int whenToStop;

  public ExampleConsumer(ThreadSafeBuffer buffer, int whenToStop) {
    this.buffer = buffer;
    this.readSoFar = 0;
    this.whenToStop = whenToStop;
  }

  private void readFromBuffer() throws Exception {

    synchronized (this) {
      while (this.buffer.isEmpty()) {
        this.wait();
      }

      System.out.println("Pobrałem " + this.buffer.get());
      ++this.readSoFar;

      this.notifyAll();
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
