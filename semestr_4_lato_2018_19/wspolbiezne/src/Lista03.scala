class MyQueue[A](val forehead: List[A], val waitingInReverse: List[A]) {
  def this() =
    this(List(), List())

  def enqueue(elem: A): MyQueue[A] =
    this match {
      case _ if this.forehead.isEmpty =>
        new MyQueue[A]((elem :: this.waitingInReverse).reverse, Nil)
      case _ =>
        new MyQueue[A](this.forehead, elem :: this.waitingInReverse)
    }

  def first: A = {
    if (this.isEmpty)
      throw new Exception("popping from empty queue")
    this.forehead.head

  }

  def firstOption: Option[A] = {
    this.forehead.headOption
  }

  def dequeue: MyQueue[A] =
    this match {
      case _ if this.isEmpty =>
        MyQueue.empty
      case _ if this.forehead.length == 1 =>
        new MyQueue[A](this.waitingInReverse.reverse, Nil)
      case _ =>
        new MyQueue[A](this.forehead.tail, this.waitingInReverse)
    }

  def isEmpty: Boolean =
    this.forehead.isEmpty && this.waitingInReverse.isEmpty
}

object MyQueue {
  def apply[A](initialElements: A*) = new MyQueue[A](initialElements.toList, Nil)
  def apply = new MyQueue(Nil, Nil)
  def empty[A]: MyQueue[A] = new MyQueue[A](Nil, Nil)
}

object Lista03 extends App {
  override def main(args: Array[String]): Unit = {
    val q: MyQueue[Int] = MyQueue.empty
    var qModified = q.enqueue(1)
    qModified = qModified.enqueue(2)
    qModified = qModified.enqueue(3)

    println(q.firstOption)
    println(qModified.first)

    qModified = qModified.dequeue
    println(qModified.firstOption)

    qModified = qModified.dequeue
    println(qModified.firstOption)

    qModified = qModified.dequeue
    println(qModified.firstOption)

    println(MyQueue.empty.firstOption)
    println(MyQueue.empty.dequeue.firstOption)
  }
}
