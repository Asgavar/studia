class MyQueue[+A](private val foreahead: List[A], private val waitingInReverse: List[A]) {
  def this() =
    this(List(), List())

  def enqueue(elem: A): MyQueue[A] =
    new MyQueue(foreahead, elem :: waitingInReverse)

  def first: A =
    this.maybeDoTheSwitch().foreahead.head

  def firstOption: Option[A] = {
    this.maybeDoTheSwitch().foreahead.headOption
  }

  def dequeue: MyQueue[A] =
    this match {
      case queue if queue.foreahead.isEmpty && queue.waitingInReverse.isEmpty => MyQueue.empty
      case queue if queue.foreahead.isEmpty => new MyQueue(waitingInReverse.reverse, Nil)
      case queue => new MyQueue(queue.foreahead.tail, waitingInReverse)
    }

  def isEmpty: Boolean =
    this.foreahead.isEmpty && this.waitingInReverse.isEmpty

  private def maybeDoTheSwitch(): MyQueue[A] =
    if (this.foreahead.isEmpty) new MyQueue(waitingInReverse.reverse, Nil) else this
}

object MyQueue {
  def apply[A](initialElements: A*) = new MyQueue[A](initialElements.toList, Nil)
  def apply = new MyQueue(Nil, Nil)
  def empty[A]: MyQueue[A] = MyQueue()
}
