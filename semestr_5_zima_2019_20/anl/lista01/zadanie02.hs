xn :: Double -> Double
xn 0 = 1
xn 1 = 1/3
xn n = 1/3 * (-299*xn(n-1) + 100*xn(n-2))

main :: IO ()
main = do
  putStr result
  where
    result = concat [i ++ "=" ++ xn(i) | i <- [1.0,2.0..10.0]]
