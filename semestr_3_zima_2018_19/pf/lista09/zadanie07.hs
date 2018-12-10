data Tree a = Node (Tree a) a (Tree a) | Leaf
data Set a = Fin (Tree a) | Cofin (Tree a)
