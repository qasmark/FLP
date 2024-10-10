module Fib where

fibonacci :: Integer -> Integer
fibonacci n | n == 0 = 0
            | n == 1 = 1
            | n == -1 = 1
            | n > 0 =  fibonacci (n - 1) +  fibonacci (n - 2)
            | n < 0 = fibonacci (n + 1) * (-1) + fibonacci (n + 2)
            | otherwise = error "Type should be Integer"


negFibonacci :: Integer -> Integer
negFibonacci n
  | n >= 0    = helper 0 1 n
  | otherwise = (-1)^(abs n + 1) * fibonacci (abs n)
  where
    helper n1 n2 0 = n1
    helper n1 n2 times = helper n2 (n1 + n2) (times - 1)



main :: IO()
main = do
    print $ fibonacci $ 10
    print $ fibonacci $ -10
    --print $ fibonacci $ 5
    --print $ fibonacci $ 6