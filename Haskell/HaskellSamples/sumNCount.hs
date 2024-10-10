module SumNCount where

import Data.Char (isDigit)

sum'n'count :: Integer -> (Integer, Integer)
sum'n'count x = (sum digits, fromIntegral (length digits))
    where digits = map (\c -> read [c] :: Integer) (filter isDigit (show (abs x)))

main :: IO ()

main = print $ sum'n'count (-123)