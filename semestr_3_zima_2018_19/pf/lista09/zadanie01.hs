notDivisableByHead :: [Integer] -> [Integer]
notDivisableByHead xs =
  [x | x <- xs, x `mod` head xs > 0]

primes :: [Integer]
-- primes = iterate (\x -> head (notDivisableByHead [x..])) 2
primes = iterate (\x -> head (notDivisableByHead [x..])) 2
-- primes = 2 : [x | x <- [3..],
--               all (\xs -> x `elem` xs) [notDivisableByHead [y..] | y <- [3..x]]]

main :: IO ()
main = do
  print (take 5 (notDivisableByHead [2..]))
  print (take 5 primes)
