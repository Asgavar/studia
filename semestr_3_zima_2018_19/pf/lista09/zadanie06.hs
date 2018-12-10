(><) :: [a] -> [b] -> [(a, b)]
-- (><) _ [] = []
-- (><) [] _ = []
(><) xs ys = [(x, y) | x <- xs, y <- ys]

main :: IO ()
main = do
  print ([1, 2] >< [3, 4])
  print (take 5 ([0..] >< [0..]))
  print ([1] >< [2])
