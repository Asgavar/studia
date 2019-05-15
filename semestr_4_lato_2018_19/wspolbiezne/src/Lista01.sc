/* Zadanie 1. */
def reverse[A](xs: List[A]): List[A] = {
  def _reverse[A](xs: List[A], acc: List[A]): List[A] = {
    xs match {
      case Nil => acc
      case hd :: tl => _reverse(tl, hd :: acc)
    }
  }

  _reverse(xs, Nil)
}

reverse(1 :: 2 :: 3 :: 4 :: 5 :: Nil)
reverse(List('a', 'b', 'c', 'd', 'e'))

/* Zadanie 2. */
def exists[A](xs: List[A], predicate: A => Boolean): Boolean = {
  xs match {
    case Nil => false
    case hd :: tl => if (predicate(hd)) true else exists(tl, predicate)
  }
}

def existsFoldLeft[A](xs: List[A], predicate: A => Boolean): Boolean =
  xs.foldLeft(false)((wasThereAlready: Boolean, elem: A) => wasThereAlready || predicate(elem))

def existsFoldRight[A](xs: List[A], predicate: A => Boolean): Boolean =
  xs.foldRight(false)((elem: A, wasThereAlready: Boolean) => wasThereAlready || predicate(elem))

exists(List(1, 2, 3, 4), (x: Int) => x >= 5)
exists(List("jeden", "dwa", "czterdzieści dwa"), (s: String) => s.contains("czter"))
existsFoldLeft(List(1, 2, 3, 4), (x: Int) => x >= 5)
existsFoldLeft(List("jeden", "dwa", "czterdzieści dwa"), (s: String) => s.contains("czter"))
existsFoldRight(List(1, 2, 3, 4), (x: Int) => x >= 5)
existsFoldRight(List("jeden", "dwa", "czterdzieści dwa"), (s: String) => s.contains("czter"))

sealed trait BinaryTree[+A]
case object Empty extends BinaryTree[Nothing]
case class Node[+A](elem: A, left: BinaryTree[A], right: BinaryTree[A]) extends BinaryTree[A]

/* Zadanie 3. */
def sumBinaryTree(tree: BinaryTree[Int]): Int = {
  tree match {
    case Empty => 0
    case Node(curr, left, right) => curr + sumBinaryTree(left) + sumBinaryTree(right)
  }
}

val testTree = Node(1, Node(2, Empty, Node(3, Empty, Empty)), Empty)

sumBinaryTree(testTree)

/* Zadanie 4. */
def foldBinaryTree[A, B](f: A => (B, B) => B)(acc: B)(tree: BinaryTree[A]): B =
  tree match {
    case Empty => acc
    case Node(elem, left, right) => {
      val leftResult = foldBinaryTree(f)(acc)(left)
      val rightResult = foldBinaryTree(f)(acc)(right)
      f(elem)(leftResult, rightResult)
    }
  }

/* Zadanie 5. */
def sumBinaryTreeFold(tree: BinaryTree[Int]): Int = {
  def _func(elem: Int)(leftResult: Int, rightResult: Int) =
    elem + leftResult + rightResult
  foldBinaryTree(_func)(0)(tree)
}

sumBinaryTreeFold(testTree)
