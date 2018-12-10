fib :: [Integer]
fib = 1 : 1 : zipWith (+) fib (tail fib)

main :: IO ()
main = do
  print (take 10 fib)
  print (fib !! 100)
