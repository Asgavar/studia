data Tree a = Leaf | Node (Tree a) (Maybe a) (Tree a) deriving (Show)
data Array a = Array {
  maxIdx :: Int,
  tree   :: Tree a
} deriving (Show)

aempty :: Array a
aempty = Array {maxIdx=(-1), tree=Leaf}

asub :: Array a -> Integer -> a
asub arr idx = aux (tree arr) idx
  where
    aux :: Tree a -> Integer -> a
    aux (Node _ (Just elem) _) 0 = elem
    aux (Node ltree _ rtree) idx =
      if mod idx 2 == 0
      then aux ltree (div idx 2)
      else aux rtree (div idx 2)

aupdate :: Array a -> Integer -> a -> Array a
aupdate arr idx elem = Array {tree=aux (tree arr) idx, maxIdx=(maxIdx arr) + 1}
  where
    -- aux :: Tree a -> Integer -> Tree a
    aux (Node ltree _ rtree) 0 = Node ltree (Just elem) rtree
    aux (Node ltree oldelem rtree) idx =
      if mod idx 2 == 0
      then Node (aux ltree (div idx 2)) oldelem rtree
      else Node ltree oldelem (aux rtree (div idx 2))

ahiext :: Array a -> a -> Array a
ahiext arr newelem = Array {
  tree=tinsert (tree arr) (Just newelem) ((maxIdx arr)+1),
  maxIdx=(maxIdx arr)+1
}
  where
    tinsert Leaf elem 0 = Node Leaf elem Leaf
    tinsert (Node Leaf _ Leaf) elem 0 = Node Leaf elem Leaf
    tinsert (Node Leaf oldelem rtree) elem idx = tinsert (Node (Node Leaf Nothing Leaf) oldelem rtree) elem idx
    tinsert (Node ltree oldelem Leaf) elem idx = tinsert (Node ltree oldelem (Node Leaf Nothing Leaf)) elem idx
    tinsert (Node ltree oldelem rtree) elem idx =
      if (mod idx 2) == 0
      then (Node (tinsert ltree elem (div idx 2)) oldelem rtree)
      else (Node ltree oldelem (tinsert rtree elem (div idx 2)))

ahirem :: Array a -> Array a
ahirem arr = Array {tree=rmlast (tree arr) (maxIdx arr), maxIdx=(maxIdx arr)-1}
  where
    rmlast (Node _ _ _) 0 = Leaf
    rmlast (Node ltree elem rtree) idx =
      if (mod idx 2) == 0
      then Node (rmlast ltree (div idx 2)) elem rtree
      else Node ltree elem (rmlast rtree (div idx 2))



main :: IO ()
main = let testCase = (ahiext (ahiext (ahiext aempty 42) 43) 44)
       in do print testCase
             print (aupdate testCase 1 997)
             print (asub testCase 0)
             print (asub testCase 1)
             print (asub testCase 2)
             print (ahirem testCase)
