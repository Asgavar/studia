import java.util.concurrent.ArrayBlockingQueue

import scala.concurrent.{Await, Future}
import scala.concurrent.duration.Duration
import scala.concurrent.ExecutionContext.Implicits.global

class Producer(name: String, buf: ArrayBlockingQueue[Int]) extends Thread(name) {
  override def run: Unit =
    for (i <- 1 to 10) {println(s"$getName producing $i"); buf.put(i)}
}

class Consumer(name: String, buf: ArrayBlockingQueue[Int]) extends Thread(name) {
  override def run =
    for (i <- 1 to 10) println(s"$getName consumed ${buf.take}")
}

object prodCons {
  def main(args: Array[String]) {
    var arr = new ArrayBlockingQueue[Int](5)
    new Producer("Producer1", arr).start
    new Producer("Producer2", arr).start
    new Consumer("Consumer1", arr).start
    new Consumer("Consumer2", arr).start
  }
}

object ZadanieDrugieListaPiata extends App {
  def pairFutZip[A, B](fut1: Future[A], fut2: Future[B]) =
    fut1.zip(fut2)

  def pairFutFor[A, B](fut1: Future[A], fut2: Future[B]) =
    for {
      fst <- fut1
      snd <- fut2
    } yield (fst, snd)

  override def main(args: Array[String]): Unit = {
    val fut1 = Future{42}
    val fut2 = Future{21.38}

    Await.result(fut1, Duration("1 second"))
    println(fut1.value)
    println(fut2.value)

    val zipped = pairFutZip(fut1, fut2)
    Await.result(zipped, Duration("1 second"))
    println(zipped)

    val fored = pairFutFor(fut1, fut2)
    Await.result(fored, Duration("1 second"))
    println(fored)
  }
}