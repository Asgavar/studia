{-# LANGUAGE FunctionalDependencies, FlexibleContexts, FlexibleInstances #-}

import Data.Char

class Monad m => StreamTrans m i o | m -> i o where
  readS :: m (Maybe i)
  emitS :: o -> m ()

streamToLower :: StreamTrans m Char Char => m Integer
streamToLower =
  aux 0
  where
    aux loweredCount = do
      next <- readS
      case next of
        Nothing ->
          return loweredCount
        Just c -> do
          emitS (toLower c)
          if isUpper c then
            aux (loweredCount + 1)
          else aux loweredCount

instance StreamTrans IO Char Char where
  readS = do
    entered <- getChar
    if entered == '\n' then
      return Nothing
    else return (Just entered)
  emitS c = print c

main :: IO ()
main = do
  ret <- streamToLower
  print ret
