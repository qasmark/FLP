module SeqA where

seqA :: Integer -> Integer
seqA n 
    | n >= 0    = helper 1 2 3 n
    | otherwise = error "Index sequence must be >= 0" 
    where
        helper n1 n2 n3 0 = n1
        helper n1 n2 n3 1 = n2
        helper n1 n2 n3 2 = n3
        helper n1 n2 n3 times = helper n2 n3 (n3 + n2 - 2 * n1) (times -1)
