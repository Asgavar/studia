data Color = Red | Black deriving (Show)
data RBTree a = RBNode Color (RBTree a) a (RBTree a) | RBLeaf deriving (Show)

balancedrbtree :: a -> a -> a -> RBTree a -> RBTree a -> RBTree a -> RBTree a -> RBTree a
balancedrbtree x y z a b c d = (RBNode Red
                                 (RBNode Black a x b)
                                 y
                                 (RBNode Black c z d))

rbnode :: Color -> RBTree a -> a -> RBTree a -> RBTree a
rbnode Black (RBNode Red (RBNode Red a x b) y c) z d =
  balancedrbtree x y z a b c d
rbnode Black a x (RBNode Red (RBNode Red b y c) z d) =
  balancedrbtree x y z a b c d
rbnode Black a x (RBNode Red b y (RBNode Red c z d)) =
  balancedrbtree x y z a b c d
rbnode Black (RBNode Red a x (RBNode Red b y c)) z d =
  balancedrbtree x y z a b c d
rbnode color RBLeaf newelem RBLeaf =
  RBNode color RBLeaf newelem RBLeaf
rbnode color RBLeaf newelem (RBNode rcolor rltree relem rrtree) =
  RBNode color RBLeaf newelem (rbnode rcolor rltree relem rrtree)
rbnode color (RBNode lcolor lltree lelem lrtree) newelem RBLeaf =
  RBNode color (rbnode lcolor lltree lelem lrtree) newelem RBLeaf
rbnode color (RBNode lcolor lltree lelem lrtree) newelem (RBNode rcolor rltree relem rrtree) =
  RBNode color (rbnode lcolor lltree lelem lrtree) newelem (rbnode rcolor rltree relem rrtree)

_rbinsert :: Ord a => a -> RBTree a -> RBTree a
_rbinsert newelem RBLeaf = RBNode Red RBLeaf newelem RBLeaf
_rbinsert newelem (RBNode color ltree v rtree) =
  if newelem < v
  then rbnode color (_rbinsert newelem ltree) v rtree
  else rbnode color ltree v (_rbinsert newelem rtree)

rbinsert :: Ord a => a -> RBTree a -> RBTree a
rbinsert newelem tree =
  let inserted = _rbinsert newelem tree in
    case inserted of
      RBNode _ ltree insertedelem rtree -> RBNode Black ltree insertedelem rtree


main :: IO ()
main = do
  print (rbinsert 99 (rbinsert 41 (rbinsert 43 (rbinsert 42 RBLeaf))))
