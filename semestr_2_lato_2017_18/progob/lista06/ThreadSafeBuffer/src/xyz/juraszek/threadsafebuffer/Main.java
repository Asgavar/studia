package xyz.juraszek.threadsafebuffer;

public class Main {

    public static void main(String[] args) {

      ThreadSafeBuffer<String> sharedBuffer = new ThreadSafeBuffer<>(64);
      ExampleProducer producer = new ExampleProducer(sharedBuffer, 64);
      ExampleConsumer consumer = new ExampleConsumer(sharedBuffer, 64);

      (new Thread(producer)).start();
      (new Thread(consumer)).start();
    }
}
