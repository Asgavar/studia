package xyz.juraszek.command;

import java.util.concurrent.SynchronousQueue;

public class CommandInvokingThread extends Thread {
  private SynchronousQueue<Command> queue;

  public CommandInvokingThread(SynchronousQueue<Command> queue) {
    this.queue = queue;
  }

  @Override
  public void run() {
    while (true) {
      try {
        this.queue.take().execute();
      } catch (Exception e) {
        e.printStackTrace();
      }
    }
  }
}
