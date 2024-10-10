fibonacci :: Integer -> Integer
fibonacci n | n == 0 = 0
            | n == 1 = 1
            | n == -1 = 1
            | n > 0 =  fibonacci (n - 1) +  fibonacci (n - 2)
            | n < 0 = fibonacci (n + 1) * (-1) + fibonacci (n + 2)
            | otherwise = error "Type should be Integer"


main :: IO()
main = do
    print $ fibonacci $ 10
    print $ fibonacci $ -10
    --print $ fibonacci $ 5
    --print $ fibonacci $ 6