-- 2. Используя функции head и tail получить элемент 'b' из следующих списков
-- 1) ['a', 'b', 'c']
getB1 :: [Char] -> Char
getB1 = head . tail

-- 2) [['a', 'b'], ['c','d']]
getB2 :: [[Char]] -> Char
getB2 = head . tail . head

-- 3) [['a', 'c', 'd'], ['a','b']]
getB3 :: [[Char]] -> Char
getB3 = head . tail . head . tail

-- 4) [['a','d'], ['b', 'c']]
getB4 :: [[Char]] -> Char
getB4 = head . head . tail


main :: IO ()
main = do	
    print (getB1 ['a', 'b', 'c'])
    print (getB2 [['a', 'b'], ['c', 'd']])
    print (getB3 [['a', 'c', 'd'], ['a','b']])
    print (getB4 [['a','d'], ['b', 'c']])
    