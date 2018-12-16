data BTree a = Leaf | Node (BTree a) a (BTree a) deriving Show

dfnum :: BTree a -> BTree Integer
dfnum tree = fst (aux tree 1)
  where
    aux Leaf counter = (Leaf, counter)
    aux (Node ltree _ rtree) counter =
      let processed_ltree = aux ltree (counter + 1)
          processed_rtree = aux rtree (snd processed_ltree)
      in (Node (fst processed_ltree) counter (fst processed_rtree), snd processed_rtree)

main :: IO ()
main = print (dfnum (Node (Node (Node Leaf 'a' Leaf) 'b' Leaf) 'c' (Node Leaf 'd' Leaf)))
