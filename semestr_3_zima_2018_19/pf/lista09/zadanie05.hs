sublists :: [a] -> [[a]]
sublists [] = [[]]
sublists (hd : tl) = [hd : sub | sub <- sublists tl] ++ sublists tl

main :: IO ()
main = do
  print (sublists [1, 2, 3, 4])
  print (sublists [7])
