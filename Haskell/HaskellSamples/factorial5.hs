factorial5 :: Integer -> Integer
factorial5 n | n >= 0 = helper 1 n 
             | otherwise = error "args must be >= 0"

helper :: Integer -> Integer -> Integer 
helper acc 0 = acc -- терминирующее условие
helper acc n = helper (acc * n) (n - 1) -- параметры изменяются

main :: IO()

main = do 
    print $ factorial5 6