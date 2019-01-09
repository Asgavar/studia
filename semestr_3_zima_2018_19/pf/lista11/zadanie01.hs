ana :: (b -> Maybe (a, b)) -> b -> [a]
ana f state = case f state of
  Nothing -> []
  Just (val, state') -> val : ana f state'

cata :: (a -> b -> b) -> b -> [a] -> b
cata f v [] = v
cata f v (hd : tl) = f hd (cata f v tl)

anazip :: [a] -> [b] -> [(a, b)]
anazip xs ys =
  ana func (xs, ys)
  where
    func ([], []) = Nothing
    func (xhd : xtl, yhd : ytl) = Just ((xhd, yhd), (xtl, ytl))

anaiterate :: (a -> a) -> a -> [a]
anaiterate fiter startingelem =
  ana func startingelem
  where
    func state = Just (state, fiter state)

anamap :: (a -> b) -> [a] -> [b]
anamap f xs =
  ana func xs
  where
    func [] = Nothing
    func (hd : tl) = Just (f hd, tl)

catalength :: [a] -> Int
catalength xs =
  cata func 0 xs
  where
    func = \a b -> b + 1

catafilter :: (a -> Bool) -> [a] -> [a]
catafilter pred xs =
  cata func [] xs
  where
    func y ys = if pred y then y : ys else ys

catamap :: (a -> b) -> [a] -> [b]
catamap f xs =
  cata func [] xs
  where
    func y ys = (f y) : ys

data Expr a b =
    Number b
  | Var a
  | Plus (Expr a b) (Expr a b)

main :: IO ()
main = do
  print (anazip [1,3,5,7] [2,4,6,8])
  print (take 10 (anaiterate (\x -> x + 1) 0))
  print (anamap (\x -> x * 2) [1,2,3,4,5])
  print (catalength [1,2,3,4,5])
  print (catafilter (\e -> e `mod` 2 == 0) [0,1,2,3,4,5])
  print (catamap (\x -> x * 2) [1,2,3,4,5])
