module Fact where

-- ветвление
factorial n = if n == 0 then 1 else n * factorial (n - 1) 

-- сопоставление с образцом
factorial' 0 = 1
factorial' n = n * factorial' (n - 1) -- неопроверживый образец

factorial'' 0 = 1
factorial'' n = if n < 0 then error "arg must be >= 0 " else n * factorial'' (n - 1)

main :: IO ()

main = do
    print $ factorial 6
    print $ factorial' 12
    print $ factorial'' 4   
    print $ factorial'' $ -5