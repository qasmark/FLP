factorial'' 0 = 1
factorial'' n = if n < 0 then error "arg must be >= 0 " else n * factorial'' (n - 1)

factorial''' 0 = 1
factorial''' n | n < 0 = error "args must be >= 0"
               | n > 0 = n * factorial'''(n - 1)


-- три охранных выражения (otherwise - оставшийся случай)
factorial4 :: Integer -> Integer
factorial4 n | n == 0	=  1
			 | n > 0    = n * factorial4 (n - 1)
			 | otherwise = error "args must be >= 0"

main :: IO ()

main = do
    print $ factorial''' 4
    print $ factorial''' $ -5

    print $ factorial4 6
    print $ factorial4 $ -15