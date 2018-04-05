package xyz.juraszek.threadsafebuffer;

public class Main {

    public static void main(String[] args) {

      ThreadSafeBuffer<String> sharedBuffer = new ThreadSafeBuffer<>(10);
      Object lock = new Object();
      ExampleProducer producer = new ExampleProducer(sharedBuffer, 64, lock);
      ExampleConsumer consumer = new ExampleConsumer(sharedBuffer, 64, lock);


      (new Thread(producer)).start();
      (new Thread(consumer)).start();
    }
}
