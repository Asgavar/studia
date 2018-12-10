iperm :: [a] -> [[a]]
iperm [] = [[]]
iperm [x] = [[x]]
iperm (x : xs) =
  concatMap (\prevperm -> [insertAt x prevperm idx | idx <- [0..length prevperm]]) (iperm xs)

insertAt :: a -> [a] -> Int -> [a]
insertAt newelem xs 0 = newelem : xs
insertAt newelem xs at = head xs : insertAt newelem (tail xs) (at - 1)

selections :: [a] -> [(a, [a])]
selections [] = []
selections (hd : tl) = (hd, tl) : [(hd', hd : tl') | (hd', tl') <- selections tl]

sperm :: [a] -> [[a]]
sperm [x] = [[x]]
sperm xs = [y : zs | (y, ys) <- selections xs, zs <- sperm ys]

main :: IO ()
main = do
  print (iperm [42])
  print (iperm [11, 22])
  print (iperm [1, 2, 3])
  print (length (iperm [1..6]))
  print (sperm [42])
  print (sperm [11, 22])
  print (sperm [1, 2, 3])
  print (length (sperm [1..6]))
