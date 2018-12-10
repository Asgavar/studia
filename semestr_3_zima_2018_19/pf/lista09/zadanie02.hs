primes :: [Integer]
primes = 2 : [p | p <- [3..], all (\q -> p `mod` q > 0) [2..floor (sqrt (fromIntegral p))]]

main :: IO ()
main = do
  print (take 10 primes)
  print (take 100 primes)
