package xyz.juraszek.command;

import java.util.concurrent.SynchronousQueue;

public class Main {
  public static void main(String[] args) {
    SynchronousQueue <Command> queue = new SynchronousQueue<>(true);
    Thread producerThread = new AutomatedCommandFactoryThread(queue);
    Thread consumerThreadOne = new CommandInvokingThread(queue);
    Thread consumerThreadTwo = new CommandInvokingThread(queue);
    producerThread.start();
    consumerThreadOne.start();
    consumerThreadTwo.start();
  }
}
