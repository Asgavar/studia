import java.util.concurrent.{Callable, Semaphore, Executors}

object Zad1Monitor extends App {
  var counter = 0
  var monitor = new AnyRef

  def readWriteCounter(): Unit = {
    monitor.synchronized {
      val incrementedCounter = counter + 1
      counter = incrementedCounter
    }
  }

  val p = new Thread(() => for(_ <- 0 until 200000) readWriteCounter)
  val q = new Thread(() => for(_ <- 0 until 200000) readWriteCounter)

  val startTime = System.nanoTime

  p.start; q.start
  p.join; q.join

  val estimatedTime = (System.nanoTime - startTime)/1000000

  println(s"The value of counter = $counter")
  println(s"Estimated time = ${estimatedTime}ms, Available processors = ${Runtime.getRuntime.availableProcessors}")
}

object Zad1Semafor extends App {
  var counter = 0
  var semaphore = new Semaphore(1)

  def readWriteCounter(): Unit = {
    semaphore.acquire()
    val incrementedCounter = counter + 1
    counter = incrementedCounter
    semaphore.release()
  }

  val p = new Thread(() => for(_ <- 0 until 200000) readWriteCounter)
  val q = new Thread(() => for(_ <- 0 until 200000) readWriteCounter)

  val startTime = System.nanoTime

  p.start; q.start
  p.join; q.join

  val estimatedTime = (System.nanoTime - startTime)/1000000

  println(s"The value of counter = $counter")
  println(s"Estimated time = ${estimatedTime}ms, Available processors = ${Runtime.getRuntime.availableProcessors}")
}

object ZadanieDrugie extends App {
  def parallel[A, B](block1: => A, block2: => B): (A, B) = {

    class Klass1 extends AnyRef with Callable[A] {
      override def call(): A = block1
    }

    class Klass2 extends AnyRef with Callable[B] {
      override def call(): B = block2
    }

    val executorsPool = Executors.newFixedThreadPool(2)

    val result1 = executorsPool.submit(new Klass1)
    val result2 = executorsPool.submit(new Klass2)

    (result1.get(), result2.get())
  }

  println(parallel("a"+1, "b"+2))
  println(parallel(Thread.currentThread.getName, Thread.currentThread.getName))
}

object ZadanieTrzecie extends App {
  def periodically(duration: Long, times: Int)(block: => Unit): Unit = ???
}
