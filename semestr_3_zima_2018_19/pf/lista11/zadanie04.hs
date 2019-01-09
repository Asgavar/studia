import System.Random

main :: IO ()
main = do
  let board = [5,4,3,2,1]
  gameLoop board

data Guess = Guess
  { rowIdx :: Int
  , starsCount :: Int
  } deriving (Show)

readGuess :: IO Guess
readGuess = do
  putStrLn "Który rząd?"
  row <- getLine
  putStrLn "Ile gwiazdek?"
  count <- getLine
  return Guess
    { rowIdx = read row :: Int
    , starsCount = read count :: Int
    }

isItEnd :: [Int] -> Bool
isItEnd rows = all (== 0) rows

gameLoop :: [Int] -> IO ()
gameLoop board =
  if isItEnd board then
    return ()
  else do
    print board
    gamersGuess <- readGuess
    boardAfterGamer <- applyGuess gamersGuess board
    cpuGuess <- computerGuess boardAfterGamer
    boardAfterCpu <- applyGuess cpuGuess boardAfterGamer
    print "Ruch komputera: "
    print cpuGuess
    gameLoop boardAfterCpu

applyGuess :: Guess -> [Int] -> IO [Int]
applyGuess guess board =
  let (hd, stars : tl) = splitAt (rowIdx guess) board
  in return (hd ++ (stars - (starsCount guess)) : tl)

computerGuess :: [Int] -> IO Guess
computerGuess board = do
  row <- randomIO :: IO Int
  count <- randomIO :: IO Int
  return Guess
    { rowIdx = row `mod` 5
    , starsCount = count `mod` (board !! (row `mod` 5))
    }
